
// ai_analysis_screen_english_readable.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'scenario_recommendation_screen.dart';

class AIAnalysisScreen extends StatefulWidget {
  final File capturedImage;
  final Map<String, dynamic> analysisResult;
  final bool isFromCamera;

  const AIAnalysisScreen({
    Key? key,
    required this.capturedImage,
    required this.analysisResult,
    required this.isFromCamera,
  }) : super(key: key);

  @override
  _AIAnalysisScreenState createState() => _AIAnalysisScreenState();
}

class _AIAnalysisScreenState extends State<AIAnalysisScreen> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  bool _isLoadingMoreDetails = false;
  Map<String, dynamic>? _detailedAnalysis;

  // 🔥 FLASK AI ADVISOR URL - PASTE YOUR AI ADVISOR URL HERE
  static const String AI_ADVISOR_URL = "http://your-flask-server.com/ai-advisor";
  static const String DETAILED_ANALYSIS_URL = "http://your-flask-server.com/detailed-analysis";

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.shade400.withOpacity(0.1),
                  Colors.blue.shade400.withOpacity(0.1),
                ],
              ),
            ),
          ),

          // MAIN FIX: Use Column with proper constraints
          SafeArea(
            child: Column(
              children: [
                // Header with image preview - FIXED: Set exact height
                SizedBox(
                  height: 200, // FIXED: Reduced from 280 to 200 to prevent overflow
                  child: _buildHeader(),
                ),

                // Analysis results - FIXED: Use Expanded for remaining space
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildAnalysisContent(),
                  ),
                ),
              ],
            ),
          ),

          // Loading overlay for additional analysis
          if (_isLoadingMoreDetails) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          // Background image with overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(widget.capturedImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Header controls - FIXED: Use Positioned to prevent overflow
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(16), // FIXED: Reduced padding
              child: Column(
                children: [
                  // Top bar - FIXED: Constrain height
                  SizedBox(
                    height: 44, // FIXED: Fixed height for top bar
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(10), // FIXED: Reduced padding
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20, // INCREASED: Icon size for better visibility
                            ),
                          ),
                        ),
                        Expanded( // FIXED: Use Expanded instead of Spacer + Flexible
                          child: Center(
                            child: Text(
                              "🤖 AI Analysis Results",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // INCREASED: Font size for better readability
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _shareResults,
                          child: Container(
                            padding: EdgeInsets.all(10), // FIXED: Reduced padding
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 20, // INCREASED: Icon size for better visibility
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  // Analysis summary at bottom - FIXED: Constrain height
                  Container(
                    height: 80, // FIXED: Set specific height
                    padding: EdgeInsets.all(12), // FIXED: Reduced padding
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12), // FIXED: Reduced radius
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 22), // INCREASED: Icon size
                        SizedBox(width: 8), // FIXED: Reduced spacing
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center, // FIXED: Center align
                            children: [
                              Text(
                                "Detected: ${widget.analysisResult['crop_type'] ?? 'Unknown'}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16, // INCREASED: Font size for better readability
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1, // FIXED: Limit lines
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Confidence: ${widget.analysisResult['confidence'] ?? '0'}%",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14, // INCREASED: Font size for better readability
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1, // FIXED: Limit lines
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // FIXED: Reduced padding
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            _getHealthStatusEmoji(widget.analysisResult['health_status']),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12, // INCREASED: Font size for better readability
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // FIXED: Limit lines
                          ),
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
  }

  Widget _buildAnalysisContent() {
    // FIXED: Wrap in LayoutBuilder to handle screen constraints properly
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16), // FIXED: Reduced horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick stats cards
              _buildQuickStatsRow(),

              SizedBox(height: 16), // FIXED: Reduced spacing

              // Detailed analysis section
              _buildDetailedAnalysisCard(),

              SizedBox(height: 16), // FIXED: Reduced spacing

              // Recommendations section
              _buildRecommendationsCard(),

              SizedBox(height: 16), // FIXED: Reduced spacing

              // Action buttons
              _buildActionButtons(),

              SizedBox(height: 16), // FIXED: Reduced spacing

              // Additional insights (if loaded)
              if (_detailedAnalysis != null) _buildAdditionalInsights(),

              SizedBox(height: 20), // Extra padding at bottom
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Health",
            widget.analysisResult['health_status'] ?? 'Unknown',
            Icons.favorite,
            _getHealthColor(widget.analysisResult['health_status']),
          ),
        ),
        SizedBox(width: 8), // FIXED: Reduced spacing between cards
        Expanded(
          child: _buildStatCard(
            "Stage",
            widget.analysisResult['growth_stage'] ?? 'Unknown',
            Icons.eco,
            Colors.blue,
          ),
        ),
        SizedBox(width: 8), // FIXED: Reduced spacing between cards
        Expanded(
          child: _buildStatCard(
            "Yield Est.",
            widget.analysisResult['estimated_yield'] ?? 'N/A',
            Icons.agriculture,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(10), // INCREASED: Padding for better touch area
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20), // INCREASED: Icon size for better visibility
          SizedBox(height: 6), // INCREASED: Spacing for better layout
          Text(
            title,
            style: TextStyle(
              fontSize: 11, // INCREASED: Font size for better readability
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4), // INCREASED: Spacing for better layout
          Text(
            value,
            style: TextStyle(
              fontSize: 12, // INCREASED: Font size for better readability
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2, // FIXED: Allow 2 lines for value
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedAnalysisCard() {
    return Container(
      padding: EdgeInsets.all(14), // INCREASED: Padding for better spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: Colors.blue, size: 20), // INCREASED: Icon size
              SizedBox(width: 8), // INCREASED: Spacing
              Expanded(
                child: Text(
                  "📊 Detailed Analysis",
                  style: TextStyle(
                    fontSize: 16, // INCREASED: Font size for better readability
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: _getDetailedAnalysis,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // INCREASED: Padding
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "More Details",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 11, // INCREASED: Font size for better readability
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12), // INCREASED: Spacing

          // Analysis details
          _buildAnalysisDetailRow("Crop Type", widget.analysisResult['crop_type'] ?? 'Unknown'),
          _buildAnalysisDetailRow("Confidence Level", "${widget.analysisResult['confidence'] ?? '0'}%"),
          _buildAnalysisDetailRow("Health Status", widget.analysisResult['health_status'] ?? 'Unknown'),
          _buildAnalysisDetailRow("Disease Check", widget.analysisResult['disease_detected'] ?? 'Unknown'),
          _buildAnalysisDetailRow("Growth Stage", widget.analysisResult['growth_stage'] ?? 'Unknown'),
          _buildAnalysisDetailRow("Estimated Yield", widget.analysisResult['estimated_yield'] ?? 'N/A'),

          SizedBox(height: 8), // INCREASED: Spacing

          // Analysis timestamp
          Container(
            padding: EdgeInsets.all(6), // INCREASED: Padding
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]), // INCREASED: Icon size
                SizedBox(width: 6), // INCREASED: Spacing
                Expanded(
                  child: Text(
                    "Analyzed: ${_formatDateTime(widget.analysisResult['analysis_timestamp'])}",
                    style: TextStyle(
                      fontSize: 11, // INCREASED: Font size for better readability
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8), // INCREASED: Spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12, // INCREASED: Font size for better readability
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 8), // INCREASED: Spacing
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12, // INCREASED: Font size for better readability
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2, // FIXED: Allow 2 lines
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard() {
    // FIXED: Proper List handling without problematic extension
    List<String> recommendations = widget.analysisResult['recommendations'] != null
        ? List<String>.from(widget.analysisResult['recommendations'])
        : ['No recommendations available'];

    return Container(
      padding: EdgeInsets.all(14), // INCREASED: Padding for better spacing
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade50, Colors.green.shade100],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.green.shade700, size: 20), // INCREASED: Icon size
              SizedBox(width: 8), // INCREASED: Spacing
              Expanded(
                child: Text(
                  "💡 AI Recommendations",
                  style: TextStyle(
                    fontSize: 16, // INCREASED: Font size for better readability
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 12), // INCREASED: Spacing

          // FIXED: Proper recommendations list handling with constrained text
          ...List.generate(
            recommendations.length > 5 ? 5 : recommendations.length, // Limit to 5 items
                (index) {
              String recommendation = recommendations[index];
              return Container(
                margin: EdgeInsets.only(bottom: 8), // INCREASED: Spacing
                padding: EdgeInsets.all(10), // INCREASED: Padding
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8), // INCREASED: Radius
                ),
                child: IntrinsicHeight( // FIXED: Added IntrinsicHeight to prevent overflow
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 18, // INCREASED: Size for better visibility
                        height: 18, // INCREASED: Size for better visibility
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10, // INCREASED: Font size for better readability
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // INCREASED: Spacing
                      Expanded(
                        child: Text(
                          recommendation,
                          style: TextStyle(
                            fontSize: 12, // INCREASED: Font size for better readability
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 3, // INCREASED: Max lines for better content display
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary action button - Get AI Advice
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _getAIAdvice,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade600,
              padding: EdgeInsets.symmetric(vertical: 14), // INCREASED: Padding for better touch area
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: FittedBox( // FIXED: Added FittedBox to prevent text overflow
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.psychology, color: Colors.white, size: 18), // INCREASED: Icon size
                  SizedBox(width: 8), // INCREASED: Spacing
                  Text(
                    "🤖 Chat with AI Advisor", // CONVERTED TO ENGLISH
                    style: TextStyle(
                      fontSize: 14, // INCREASED: Font size for better readability
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 10), // INCREASED: Spacing

        // Secondary action button - Try Scenarios
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _tryScenarios,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: EdgeInsets.symmetric(vertical: 14), // INCREASED: Padding for better touch area
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: FittedBox( // FIXED: Added FittedBox to prevent text overflow
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.science, color: Colors.white, size: 18), // INCREASED: Icon size
                  SizedBox(width: 8), // INCREASED: Spacing
                  Text(
                    "🧪 Try Different Scenarios", // CONVERTED TO ENGLISH
                    style: TextStyle(
                      fontSize: 14, // INCREASED: Font size for better readability
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInsights() {
    return Container(
      padding: EdgeInsets.all(14), // INCREASED: Padding for better spacing
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: Colors.blue.shade700, size: 20), // INCREASED: Icon size
              SizedBox(width: 8), // INCREASED: Spacing
              Expanded(
                child: Text(
                  "🔍 Additional Insights",
                  style: TextStyle(
                    fontSize: 16, // INCREASED: Font size for better readability
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 12), // INCREASED: Spacing

          // Display additional insights from detailed analysis - FIXED: Proper handling
          ...List.generate(
            _detailedAnalysis!.entries.length > 6 ? 6 : _detailedAnalysis!.entries.length, // Limit entries
                (index) {
              var entry = _detailedAnalysis!.entries.toList()[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 6), // INCREASED: Spacing
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ", style: TextStyle(color: Colors.blue.shade600, fontSize: 14)), // INCREASED: Font size
                    Expanded(
                      child: Text(
                        "${entry.key}: ${entry.value}",
                        style: TextStyle(
                          fontSize: 12, // INCREASED: Font size for better readability
                          color: Colors.blue.shade800,
                        ),
                        maxLines: 2, // FIXED: Limit lines
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24), // INCREASED: Padding for better spacing
            margin: EdgeInsets.all(24), // INCREASED: Margin for better spacing
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16), // INCREASED: Radius for modern look
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  strokeWidth: 3, // INCREASED: Stroke width for better visibility
                ),
                SizedBox(height: 16), // INCREASED: Spacing
                Text(
                  "🤖 Getting Detailed Analysis...", // CONVERTED TO ENGLISH
                  style: TextStyle(
                    fontSize: 14, // INCREASED: Font size for better readability
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8), // INCREASED: Spacing
                Text(
                  "Advanced insights loading...",
                  style: TextStyle(
                    fontSize: 12, // INCREASED: Font size for better readability
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods (unchanged)
  String _getHealthStatusEmoji(String? health) {
    if (health == null) return '❓ Unknown';
    switch (health.toLowerCase()) {
      case 'excellent': return '🌟 Excellent';
      case 'good': return '✅ Good';
      case 'fair': return '⚠️ Fair';
      case 'needs attention': return '🚨 Needs Attention';
      default: return '❓ Unknown';
    }
  }

  Color _getHealthColor(String? health) {
    if (health == null) return Colors.grey;
    switch (health.toLowerCase()) {
      case 'excellent': return Colors.green;
      case 'good': return Colors.lightGreen;
      case 'fair': return Colors.orange;
      case 'needs attention': return Colors.red;
      default: return Colors.grey;
    }
  }

  String _formatDateTime(String? timestamp) {
    if (timestamp == null) return 'Unknown';
    try {
      DateTime dt = DateTime.parse(timestamp);
      return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return 'Just now';
    }
  }

  // Action methods (unchanged)
  Future<void> _getDetailedAnalysis() async {
    setState(() {
      _isLoadingMoreDetails = true;
    });

    try {
      // Call Flask detailed analysis endpoint
      var response = await http.post(
        Uri.parse(DETAILED_ANALYSIS_URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'crop_type': widget.analysisResult['crop_type'],
          'health_status': widget.analysisResult['health_status'],
          'image_analysis': widget.analysisResult,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> detailedResult = json.decode(response.body);
        setState(() {
          _detailedAnalysis = detailedResult;
          _isLoadingMoreDetails = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback demo data
      setState(() {
        _detailedAnalysis = {
          'Soil Moisture': '65% - Optimal',
          'Nutrient Level': 'High Nitrogen, Medium Phosphorus',
          'Pest Risk': 'Low (2/10)',
          'Weather Impact': 'Positive - Good for growth',
          'Market Price': '₹2,500/quintal (Current)',
          'Best Harvest Time': '15-20 days from now',
        };
        _isLoadingMoreDetails = false;
      });
    }
  }

  void _getAIAdvice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AIAdvisorScreen(
          cropData: widget.analysisResult,
          capturedImage: widget.capturedImage,
        ),
      ),
    );
  }

  void _tryScenarios() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScenarioRecommendationScreen(
          detectedCrop: widget.analysisResult['crop_type'] ?? 'Unknown',
          currentHealth: widget.analysisResult['health_status'] ?? 'Unknown',
          analysisData: widget.analysisResult,
          isVirtualFarm: false,  // This is from real camera analysis
        ),
      ),
    );
  }

  void _shareResults() {
    // Implement sharing functionality
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("📤 Sharing functionality will be added soon!"),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class AIAdvisorScreen extends StatelessWidget {
  final Map<String, dynamic> cropData;
  final File capturedImage;

  const AIAdvisorScreen({
    Key? key,
    required this.cropData,
    required this.capturedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Custom header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.purple,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.arrow_back,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "🤖 AI Advisor",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // FIX ✅ Scrollable body instead of Expanded+Center
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.construction,
                        size: 80, color: Colors.purple.shade300),
                    SizedBox(height: 24),
                    Text(
                      "🤖 AI Advisor",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Implementation coming next...",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Here AI Advisor will give you personalized farming advice!", // CONVERTED TO ENGLISH
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.purple.shade700,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
