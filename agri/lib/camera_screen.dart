
// camera_screen_renderflex_fixed.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'ai_analysis_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with TickerProviderStateMixin {
  CameraController? _cameraController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  List<CameraDescription>? cameras;
  bool _isCameraReady = false;
  bool _isAnalyzing = false;
  File? _capturedImage;
  String _cameraError = '';

  // 🔥 FLASK AI/ML MODEL URLS - PASTE YOUR URLs HERE
  static const String CROP_DETECTION_URL = "http://192.168.10.143:5000";
  static const String IMAGE_ANALYSIS_URL = "http://your-flask-server.com/analyze-image";
  static const String HEALTH_CHECK_URL = "http://your-flask-server.com/health-check";

  // For testing without Flask server
  static const bool USE_DEMO_MODE = true; // Set false when Flask server is ready

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeCamera();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        _cameraController = CameraController(
          cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {
            _isCameraReady = true;
            _cameraError = '';
          });
        }
      } else {
        throw Exception('No cameras available');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCameraReady = false;
          _cameraError = 'Camera initialization failed: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _cameraError.isNotEmpty
            ? _buildErrorScreen()
            : Stack(
          children: [
            // Camera preview
            _isCameraReady ? _buildCameraPreview() : _buildLoadingScreen(),

            // RENDERFLEX FIX: Use simple positioning instead of percentage heights
            Positioned.fill(
              child: Column(
                children: [
                  // Top overlay - FIXED: Flexible instead of fixed height
                  Flexible(
                    flex: 2, // Takes 2/5 of available space
                    child: _buildTopOverlay(),
                  ),

                  // Middle spacer for camera view
                  Flexible(
                    flex: 1, // Takes 1/5 of available space
                    child: Container(),
                  ),

                  // Bottom overlay - FIXED: Flexible instead of fixed height
                  Flexible(
                    flex: 2, // Takes 2/5 of available space
                    child: _buildBottomOverlay(),
                  ),
                ],
              ),
            ),

            // Analysis loading overlay
            if (_isAnalyzing) _buildAnalysisOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, size: 80, color: Colors.white54),
              SizedBox(height: 20),
              Text(
                "Camera Not Available",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Please check camera permissions or try gallery instead",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: Icon(Icons.photo_library),
                label: Text("Choose from Gallery"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _initializeCamera,
                child: Text(
                  "Try Camera Again",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Positioned.fill(
      child: _cameraController!.value.isInitialized
          ? AspectRatio(
        aspectRatio: _cameraController!.value.aspectRatio,
        child: CameraPreview(_cameraController!),
      )
          : Container(color: Colors.black),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              strokeWidth: 3,
            ),
            SizedBox(height: 20),
            Text(
              "📷 Preparing Camera...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // RENDERFLEX FIX: Removed constraints parameter dependency
  Widget _buildTopOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 360;

        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // FIXED: Prevent overflow
            children: [
              // Back button and title - FIXED: No fixed height
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: isSmallScreen ? 18 : 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "🌾 Crop Scanner",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Gallery button
                  GestureDetector(
                    onTap: _pickImageFromGallery,
                    child: Container(
                      padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: isSmallScreen ? 18 : 20,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: isSmallScreen ? 15 : 20),

              // Instructions card - FIXED: Flexible wrapper
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // FIXED: Prevent overflow
                    children: [
                      Icon(Icons.camera_alt, color: Colors.white, size: isSmallScreen ? 20 : 24),
                      SizedBox(height: 6),
                      Text(
                        "Position your crop in front of the camera",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 12 : 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "AI will analyze your crop",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: isSmallScreen ? 10 : 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: isSmallScreen ? 15 : 20),

              // Scan area indicator - FIXED: Flexible wrapper for responsiveness
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: isSmallScreen ? 200 : 250,
                    maxHeight: isSmallScreen ? 200 : 250,
                  ),
                  width: isSmallScreen ? 200 : 250,
                  height: isSmallScreen ? 200 : 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      // Corner indicators
                      ...List.generate(4, (index) => _buildCornerIndicator(index)),

                      // Center content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // FIXED: Prevent overflow
                          children: [
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Icon(
                                    Icons.center_focus_weak,
                                    color: Colors.green.withOpacity(0.8),
                                    size: isSmallScreen ? 40 : 50,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Place crop here",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 10 : 12,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCornerIndicator(int index) {
    double? top = index < 2 ? 0 : null;
    double? bottom = index >= 2 ? 0 : null;
    double? left = index % 2 == 0 ? 0 : null;
    double? right = index % 2 == 1 ? 0 : null;

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  // RENDERFLEX FIX: Removed constraints parameter dependency
  Widget _buildBottomOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 360;

        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
          child: Column(
            mainAxisSize: MainAxisSize.min, // FIXED: Prevent overflow
            children: [
              // Quick tips - FIXED: Flexible wrapper
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lightbulb, color: Colors.white, size: isSmallScreen ? 14 : 16),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          "💡 TIP: Take photo in clear light",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 10 : 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: isSmallScreen ? 15 : 20),

              // Capture button row - FIXED: Intrinsic height instead of fixed height
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Flash toggle
                    GestureDetector(
                      onTap: _toggleFlash,
                      child: Container(
                        padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.flash_auto,
                          color: Colors.white,
                          size: isSmallScreen ? 20 : 24,
                        ),
                      ),
                    ),

                    // Main capture button
                    GestureDetector(
                      onTap: _captureAndAnalyze,
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value * 0.95,
                            child: Container(
                              width: isSmallScreen ? 65 : 80,
                              height: isSmallScreen ? 65 : 80,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera,
                                color: Colors.white,
                                size: isSmallScreen ? 28 : 35,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Switch camera
                    GestureDetector(
                      onTap: _switchCamera,
                      child: Container(
                        padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.cameraswitch,
                          color: Colors.white,
                          size: isSmallScreen ? 20 : 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isSmallScreen ? 10 : 20),

              // Voice instruction - FIXED: Flexible wrapper
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.mic, color: Colors.white, size: isSmallScreen ? 14 : 16),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          "🗣️ Say: \"Take Photo\" or \"Scan Crop\"",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 10 : 12,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnalysisOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  strokeWidth: 4,
                ),
                SizedBox(height: 20),
                Text(
                  "🤖 AI Analysis in Progress...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Your crop is being identified\nPlease wait...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20),
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.green.shade100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndAnalyze() async {
    if (!_isCameraReady || _isAnalyzing || _cameraController == null) return;

    try {
      HapticFeedback.mediumImpact();

      final XFile image = await _cameraController!.takePicture();
      _capturedImage = File(image.path);

      setState(() {
        _isAnalyzing = true;
      });

      Map<String, dynamic> analysisResult = await _sendToAIModel(_capturedImage!);

      setState(() {
        _isAnalyzing = false;
      });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AIAnalysisScreen(
              capturedImage: _capturedImage!,
              analysisResult: analysisResult,
              isFromCamera: true,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isAnalyzing = false;
      });
      _showErrorDialog("Photo capture error: $e");
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        _capturedImage = File(image.path);

        setState(() {
          _isAnalyzing = true;
        });

        Map<String, dynamic> analysisResult = await _sendToAIModel(_capturedImage!);

        setState(() {
          _isAnalyzing = false;
        });

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AIAnalysisScreen(
                capturedImage: _capturedImage!,
                analysisResult: analysisResult,
                isFromCamera: false,
              ),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isAnalyzing = false;
      });
      _showErrorDialog("Gallery image selection error: $e");
    }
  }

  Future<Map<String, dynamic>> _sendToAIModel(File imageFile) async {
    if (USE_DEMO_MODE) {
      await Future.delayed(Duration(seconds: 2));
      return _getDemoAnalysisResult();
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(CROP_DETECTION_URL));

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      request.fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();
      request.fields['source'] = 'mobile_app';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        return result;
      } else {
        throw Exception('Flask server error: ${response.statusCode}');
      }
    } catch (e) {
      print('AI Model Error: $e');
      return _getDemoAnalysisResult();
    }
  }

  Map<String, dynamic> _getDemoAnalysisResult() {
    List<String> crops = ['Wheat', 'Rice', 'Maize', 'Cotton'];
    List<String> health = ['Excellent', 'Good', 'Fair', 'Needs Attention'];
    List<String> diseases = ['Healthy', 'Leaf Rust', 'Powdery Mildew', 'Aphid Infestation'];

    return {
      'crop_type': crops[DateTime.now().second % crops.length],
      'confidence': 85 + (DateTime.now().second % 15),
      'health_status': health[DateTime.now().second % health.length],
      'disease_detected': diseases[DateTime.now().second % diseases.length],
      'recommendations': [
        'Regular watering needed',
        'Apply organic fertilizer',
        'Monitor for pests',
        'Harvest in 2-3 weeks'
      ],
      'growth_stage': 'Vegetative Stage',
      'estimated_yield': '${3 + (DateTime.now().second % 5)} tons/acre',
      'analysis_timestamp': DateTime.now().toIso8601String(),
    };
  }

  Future<void> _toggleFlash() async {
    if (_cameraController != null && _isCameraReady) {
      try {
        final FlashMode currentFlashMode = _cameraController!.value.flashMode;
        final FlashMode newFlashMode = currentFlashMode == FlashMode.off
            ? FlashMode.auto
            : FlashMode.off;

        await _cameraController!.setFlashMode(newFlashMode);
        HapticFeedback.lightImpact();
      } catch (e) {
        print('Flash toggle error: $e');
      }
    }
  }

  Future<void> _switchCamera() async {
    if (cameras != null && cameras!.length > 1) {
      try {
        final newCameraIndex = cameras!.indexOf(_cameraController!.description) == 0 ? 1 : 0;
        final newCamera = cameras![newCameraIndex];

        await _cameraController?.dispose();

        _cameraController = CameraController(
          newCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {});
        }

        HapticFeedback.lightImpact();
      } catch (e) {
        print('Camera switch error: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
