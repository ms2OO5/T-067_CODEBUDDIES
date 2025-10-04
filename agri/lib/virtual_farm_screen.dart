
// virtual_farm_screen_english.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'scenario_recommendation_screen.dart';

class VirtualFarmScreen extends StatefulWidget {
  @override
  _VirtualFarmScreenState createState() => _VirtualFarmScreenState();
}

class _VirtualFarmScreenState extends State<VirtualFarmScreen> with TickerProviderStateMixin {
  // Animation Controllers
  late AnimationController _plantGrowthController;
  late AnimationController _weatherController;
  late AnimationController _waterController;

  // Animations
  late Animation<double> _growthAnimation;
  late Animation<double> _weatherAnimation;
  late Animation<double> _waterAnimation;

  // Farm State
  int _selectedWeatherIndex = 0;
  int _selectedSeasonIndex = 0;
  int _selectedStateIndex = 0;
  int _selectedCropIndex = 0;
  double _farmSize = 1.0; // acres
  int _cropAge = 0; // days
  bool _isFarmPlanted = false;
  bool _isGrowthPlaying = false;

  // Farm conditions
  double _soilMoisture = 60.0;
  double _temperature = 25.0;
  String _cropHealth = "Good";

  // Weather options - CONVERTED TO ENGLISH
  final List<Map<String, dynamic>> weatherOptions = [
    {'name': '☀️ Sunny', 'icon': Icons.wb_sunny, 'color': Colors.orange, 'temp': 30, 'humidity': 40},
    {'name': '☁️ Cloudy', 'icon': Icons.cloud, 'color': Colors.grey, 'temp': 22, 'humidity': 70},
    {'name': '🌧️ Rainy', 'icon': Icons.water_drop, 'color': Colors.blue, 'temp': 20, 'humidity': 90},
    {'name': '⛈️ Stormy', 'icon': Icons.thunderstorm, 'color': Colors.purple, 'temp': 18, 'humidity': 95},
  ];

  // CONVERTED TO ENGLISH
  final List<String> seasons = ['Summer', 'Monsoon', 'Winter', 'Spring'];
  final List<String> states = ['Punjab', 'Haryana', 'Uttar Pradesh', 'Maharashtra', 'Karnataka'];

  // Crops with detailed info - CONVERTED TO ENGLISH
  final List<Map<String, dynamic>> crops = [
    {
      'name': '🌾 Wheat',
      'days': 120,
      'waterNeed': 'Medium',
      'season': 'Winter',
      'yield': '4-5 tons/acre',
      'color': Colors.amber,
      'emoji': '🌾'
    },
    {
      'name': '🌾 Rice',
      'days': 150,
      'waterNeed': 'High',
      'season': 'Monsoon',
      'yield': '3-4 tons/acre',
      'color': Colors.green,
      'emoji': '🌾'
    },
    {
      'name': '🌽 Maize',
      'days': 90,
      'waterNeed': 'Medium',
      'season': 'Summer',
      'yield': '5-6 tons/acre',
      'color': Colors.yellow,
      'emoji': '🌽'
    },
    {
      'name': '🌿 Cotton',
      'days': 180,
      'waterNeed': 'Low',
      'season': 'Summer',
      'yield': '2-3 tons/acre',
      'color': Colors.white,
      'emoji': '🌿'
    },
    {
      'name': '🎋 Sugarcane',
      'days': 365,
      'waterNeed': 'Very High',
      'season': 'Monsoon',
      'yield': '60-70 tons/acre',
      'color': Colors.lightGreen,
      'emoji': '🎋'
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Plant growth animation
    _plantGrowthController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _growthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _plantGrowthController, curve: Curves.easeInOut),
    );

    // Weather animation
    _weatherController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _weatherAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _weatherController, curve: Curves.easeInOut),
    );

    // Water animation
    _waterController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _waterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waterController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _plantGrowthController.dispose();
    _weatherController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Main content - FIXED: Added Flexible to prevent overflow
            Flexible(  // Changed from Expanded to Flexible
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step indicator
                    _buildStepIndicator(),

                    SizedBox(height: 20),

                    // Farm setup section (if not planted)
                    if (!_isFarmPlanted) ...[
                      _buildFarmSetupSection(),
                    ] else ...[
                      // Virtual farm visualization
                      _buildVirtualFarmView(),

                      SizedBox(height: 20),

                      // Farm controls
                      _buildFarmControls(),

                      SizedBox(height: 20),

                      // Farm stats
                      _buildFarmStats(),
                    ],

                    SizedBox(height: 20),

                    // Action buttons
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating help button
      floatingActionButton: FloatingActionButton(
        onPressed: _showHelpDialog,
        backgroundColor: Colors.green,
        child: Icon(Icons.help_outline, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade400, Colors.green.shade600],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🌱 Virtual Farm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26, // INCREASED: Font size for better readability
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Build your digital farm", // CONVERTED TO ENGLISH
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15, // INCREASED: Font size for better readability
                  ),
                ),
              ],
            ),
          ),
          // Voice control hint
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mic, color: Colors.white, size: 18), // INCREASED: Icon size
                SizedBox(width: 4),
                Text(
                  "Voice",
                  style: TextStyle(color: Colors.white, fontSize: 13), // INCREASED: Font size
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    int currentStep = _isFarmPlanted ? 3 : 1;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
        children: [
          Text(
            "📋 Farm Setup Steps", // CONVERTED TO ENGLISH
            style: TextStyle(
              fontSize: 17, // INCREASED: Font size for better readability
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          SizedBox(height: 12),
          // FIXED: Wrapped Row in SingleChildScrollView to handle horizontal overflow
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStepCircle(1, "Setup", currentStep >= 1),
                _buildStepLine(currentStep >= 2),
                _buildStepCircle(2, "Plant", currentStep >= 2),
                _buildStepLine(currentStep >= 3),
                _buildStepCircle(3, "Grow", currentStep >= 3),
                _buildStepLine(currentStep >= 4),
                _buildStepCircle(4, "Harvest", currentStep >= 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
      children: [
        Container(
          width: 32, // INCREASED: Size for better visibility
          height: 32, // INCREASED: Size for better visibility
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "$step",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13, // INCREASED: Font size for better readability
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11, // INCREASED: Font size for better readability
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool isActive) {
    // FIXED: Changed from Expanded to fixed width to prevent overflow
    return Container(
      width: 30,  // Fixed width instead of Expanded
      height: 2,
      color: isActive ? Colors.green : Colors.grey.shade300,
      margin: EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildFarmSetupSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
      children: [
        // Weather selection
        _buildSelectionCard(
          "🌤️ Choose Weather", // CONVERTED TO ENGLISH
          "Select the right weather for your crop", // CONVERTED TO ENGLISH
          _buildWeatherSelection(),
        ),

        SizedBox(height: 16),

        // Season and state selection
        _buildSelectionCard(
          "🗓️ Choose Season and State", // CONVERTED TO ENGLISH
          "Tell us your region and time", // CONVERTED TO ENGLISH
          _buildSeasonStateSelection(),
        ),

        SizedBox(height: 16),

        // Crop selection
        _buildSelectionCard(
          "🌱 Select Crop", // CONVERTED TO ENGLISH
          "Which crop do you want to plant?", // CONVERTED TO ENGLISH
          _buildCropSelection(),
        ),

        SizedBox(height: 16),

        // Farm size selection
        _buildSelectionCard(
          "📏 Farm Size", // CONVERTED TO ENGLISH
          "How many acres will you farm?", // CONVERTED TO ENGLISH
          _buildFarmSizeSelection(),
        ),
      ],
    );
  }

  Widget _buildSelectionCard(String title, String subtitle, Widget content) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17, // INCREASED: Font size for better readability
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15, // INCREASED: Font size for better readability
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildWeatherSelection() {
    // FIXED: Made height flexible instead of fixed
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,  // FIXED: Added shrinkWrap
        itemCount: weatherOptions.length,
        itemBuilder: (context, index) {
          final weather = weatherOptions[index];
          final isSelected = _selectedWeatherIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedWeatherIndex = index;
                _temperature = weather['temp'].toDouble();
              });
              HapticFeedback.lightImpact();
              _weatherController.forward().then((_) => _weatherController.reset());
            },
            child: Container(
              width: 90,
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isSelected
                      ? [weather['color'], weather['color'].withOpacity(0.7)]
                      : [Colors.grey.shade100, Colors.grey.shade200],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? weather['color'] : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
                children: [
                  Icon(
                    weather['icon'],
                    color: isSelected ? Colors.white : weather['color'],
                    size: 30, // INCREASED: Icon size for better visibility
                  ),
                  SizedBox(height: 8),
                  Flexible(  // FIXED: Wrapped Text in Flexible
                    child: Text(
                      weather['name'],
                      style: TextStyle(
                        fontSize: 11, // INCREASED: Font size for better readability
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeasonStateSelection() {
    return Row(
      children: [
        // Season selection
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
            children: [
              Text(
                "Season:",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15), // INCREASED: Font size
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: _showSeasonPicker,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          seasons[_selectedSeasonIndex],
                          style: TextStyle(fontSize: 15), // INCREASED: Font size
                          overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 16),

        // State selection
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
            children: [
              Text(
                "State:",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15), // INCREASED: Font size
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: _showStatePicker,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          states[_selectedStateIndex],
                          style: TextStyle(fontSize: 15), // INCREASED: Font size
                          overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCropSelection() {
    // FIXED: Made height flexible instead of fixed
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,  // FIXED: Added shrinkWrap
        itemCount: crops.length,
        itemBuilder: (context, index) {
          final crop = crops[index];
          final isSelected = _selectedCropIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCropIndex = index;
              });
              HapticFeedback.lightImpact();
            },
            child: Container(
              width: 110,
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isSelected
                      ? [Colors.green.shade400, Colors.green.shade600]
                      : [Colors.white, Colors.grey.shade50],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
                children: [
                  Text(
                    crop['emoji'],
                    style: TextStyle(fontSize: 32), // INCREASED: Emoji size for better visibility
                  ),
                  SizedBox(height: 8),
                  Flexible(  // FIXED: Wrapped Text in Flexible
                    child: Text(
                      crop['name'],
                      style: TextStyle(
                        fontSize: 13, // INCREASED: Font size for better readability
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${crop['days']} days",
                    style: TextStyle(
                      fontSize: 11, // INCREASED: Font size for better readability
                      color: isSelected ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFarmSizeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
      children: [
        // FIXED: Wrapped Row in Flexible to prevent overflow
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Farm Size: ${_farmSize.toStringAsFixed(1)} acres",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15), // INCREASED: Font size
                  overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Expected Yield: ${(_farmSize * _getYieldPerAcre()).toStringAsFixed(1)} tons",
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 13, // INCREASED: Font size for better readability
                  ),
                  overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.green,
            thumbColor: Colors.green.shade700,
            overlayColor: Colors.green.withOpacity(0.2),
            trackHeight: 4,
          ),
          child: Slider(
            value: _farmSize,
            min: 0.5,
            max: 10.0,
            divisions: 19,
            onChanged: (value) {
              setState(() {
                _farmSize = value;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("0.5 acres", style: TextStyle(fontSize: 13, color: Colors.grey)), // INCREASED: Font size
            Text("10.0 acres", style: TextStyle(fontSize: 13, color: Colors.grey)), // INCREASED: Font size
          ],
        ),
      ],
    );
  }

  Widget _buildVirtualFarmView() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.lightBlue.withOpacity(0.3), // Sky
            Colors.green.withOpacity(0.5),     // Horizon
            Colors.brown.withOpacity(0.3),     // Soil
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Weather effects overlay
          _buildWeatherEffects(),

          // Crop field
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            height: 150,
            child: _buildCropField(),
          ),

          // Farm info overlay
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
                children: [
                  Text(
                    crops[_selectedCropIndex]['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15, // INCREASED: Font size for better readability
                      color: Colors.green.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                  ),
                  Text(
                    "Day $_cropAge/${crops[_selectedCropIndex]['days']}",
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]), // INCREASED: Font size
                  ),
                ],
              ),
            ),
          ),

          // Weather info overlay
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: weatherOptions[_selectedWeatherIndex]['color'].withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    weatherOptions[_selectedWeatherIndex]['icon'],
                    color: Colors.white,
                    size: 18, // INCREASED: Icon size for better visibility
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${_temperature.toInt()}°C",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13, // INCREASED: Font size for better readability
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

  Widget _buildWeatherEffects() {
    if (_selectedWeatherIndex == 2) { // Rainy
      return AnimatedBuilder(
        animation: _weatherAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: RainPainter(_weatherAnimation.value),
            size: Size.infinite,
          );
        },
      );
    } else if (_selectedWeatherIndex == 0) { // Sunny
      return AnimatedBuilder(
        animation: _weatherAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: SunRaysPainter(_weatherAnimation.value),
            size: Size.infinite,
          );
        },
      );
    }
    return Container();
  }

  Widget _buildCropField() {
    int plantsCount = (_farmSize * 20).round(); // 20 plants per acre
    double growthProgress = _cropAge / crops[_selectedCropIndex]['days'];

    return AnimatedBuilder(
      animation: _growthAnimation,
      builder: (context, child) {
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (math.sqrt(plantsCount) + 1).round(),
            childAspectRatio: 1.0,
          ),
          itemCount: plantsCount,
          shrinkWrap: true,  // FIXED: Added shrinkWrap
          itemBuilder: (context, index) {
            double plantSize = 8 + (growthProgress * 16) * _growthAnimation.value;
            Color plantColor = Color.lerp(
              Colors.lightGreen,
              crops[_selectedCropIndex]['color'],
              growthProgress,
            )!;

            return Container(
              margin: EdgeInsets.all(1),
              child: Center(
                child: Container(
                  width: plantSize,
                  height: plantSize,
                  decoration: BoxDecoration(
                    color: plantColor,
                    borderRadius: BorderRadius.circular(plantSize / 2),
                  ),
                  child: Center(
                    child: Text(
                      crops[_selectedCropIndex]['emoji'],
                      style: TextStyle(
                        fontSize: plantSize * 0.6,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFarmControls() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: Colors.blue.shade700),
              SizedBox(width: 8),
              Text(
                "🎮 Farm Controls",
                style: TextStyle(
                  fontSize: 17, // INCREASED: Font size for better readability
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Growth control
          Row(
            children: [
              Expanded(  // FIXED: Wrapped Text in Expanded
                child: Text(
                  "Growth: Day $_cropAge/${crops[_selectedCropIndex]['days']}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15), // INCREASED: Font size
                  overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
                ),
              ),
              GestureDetector(
                onTap: _toggleGrowthAnimation,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isGrowthPlaying ? Colors.red.shade100 : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _isGrowthPlaying ? Icons.pause : Icons.play_arrow,
                    color: _isGrowthPlaying ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Slider(
            value: _cropAge.toDouble(),
            min: 0,
            max: crops[_selectedCropIndex]['days'].toDouble(),
            divisions: crops[_selectedCropIndex]['days'],
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                _cropAge = value.toInt();
                _updateCropHealth();
              });
            },
          ),

          SizedBox(height: 16),

          // Quick action buttons - FIXED: Made responsive
          LayoutBuilder(
            builder: (context, constraints) {
              // If screen is too narrow, stack buttons vertically
              if (constraints.maxWidth < 300) {
                return Column(
                  children: [
                    _buildQuickActionButton("💧 Add Water", Colors.blue, _addWater), // CONVERTED TO ENGLISH
                    SizedBox(height: 8),
                    _buildQuickActionButton("🌱 Add Fertilizer", Colors.orange, _addFertilizer), // CONVERTED TO ENGLISH
                    SizedBox(height: 8),
                    _buildQuickActionButton("🛡️ Add Pesticide", Colors.red, _addPesticide), // CONVERTED TO ENGLISH
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(child: _buildQuickActionButton("💧 Add Water", Colors.blue, _addWater)), // CONVERTED TO ENGLISH
                    SizedBox(width: 8),
                    Flexible(child: _buildQuickActionButton("🌱 Add Fertilizer", Colors.orange, _addFertilizer)), // CONVERTED TO ENGLISH
                    SizedBox(width: 8),
                    Flexible(child: _buildQuickActionButton("🛡️ Add Pesticide", Colors.red, _addPesticide)), // CONVERTED TO ENGLISH
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color.shade700,
            fontWeight: FontWeight.w600,
            fontSize: 13, // INCREASED: Font size for better readability
          ),
          textAlign: TextAlign.center,  // FIXED: Added textAlign
          overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
        ),
      ),
    );
  }

  Widget _buildFarmStats() {
    double growthProgress = _cropAge / crops[_selectedCropIndex]['days'];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
        children: [
          Text(
            "📊 Farm Statistics",
            style: TextStyle(
              fontSize: 17, // INCREASED: Font size for better readability
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),

          SizedBox(height: 16),

          Row(
            children: [
              Expanded(child: _buildStatItem("🌡️ Temperature", "${_temperature.toInt()}°C")),
              Expanded(child: _buildStatItem("💧 Soil Moisture", "${_soilMoisture.toInt()}%")),
            ],
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: _buildStatItem("💚 Crop Health", _cropHealth)),
              Expanded(child: _buildStatItem("📈 Progress", "${(growthProgress * 100).toInt()}%")),
            ],
          ),

          SizedBox(height: 16),

          // Progress bar
          Text(
            "Growth Progress",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15), // INCREASED: Font size
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: growthProgress,
            backgroundColor: Colors.green.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey[600]), // INCREASED: Font size
          overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15, // INCREASED: Font size for better readability
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,  // FIXED: Added overflow protection
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,  // FIXED: Added mainAxisSize.min
      children: [
        if (!_isFarmPlanted)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _canPlantCrop() ? _plantCrop : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "🌱 Plant Crop", // CONVERTED TO ENGLISH
                style: TextStyle(
                  fontSize: 17, // INCREASED: Font size for better readability
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        else ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _getScenarioRecommendations,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "🧪 Try AI Scenarios", // CONVERTED TO ENGLISH
                style: TextStyle(
                  fontSize: 17, // INCREASED: Font size for better readability
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _resetFarm,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red.shade400),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "🔄 Start New Farm", // CONVERTED TO ENGLISH
                style: TextStyle(
                  fontSize: 17, // INCREASED: Font size for better readability
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Helper methods (unchanged)
  bool _canPlantCrop() {
    return _selectedCropIndex >= 0 && _farmSize > 0;
  }

  double _getYieldPerAcre() {
    String yieldStr = crops[_selectedCropIndex]['yield'];
    return double.tryParse(yieldStr.split('-')[0]) ?? 3.0;
  }

  void _updateCropHealth() {
    double growthProgress = _cropAge / crops[_selectedCropIndex]['days'];

    if (growthProgress < 0.3) {
      _cropHealth = "Growing";
    } else if (growthProgress < 0.7) {
      _cropHealth = "Healthy";
    } else if (growthProgress < 1.0) {
      _cropHealth = "Excellent";
    } else {
      _cropHealth = "Ready to Harvest";
    }
  }

  // Action methods (unchanged but with English messages)
  void _plantCrop() {
    setState(() {
      _isFarmPlanted = true;
      _cropAge = 0;
    });

    _plantGrowthController.forward();
    HapticFeedback.mediumImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🌱 ${crops[_selectedCropIndex]['name']} successfully planted!"), // CONVERTED TO ENGLISH
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleGrowthAnimation() {
    setState(() {
      _isGrowthPlaying = !_isGrowthPlaying;
    });

    if (_isGrowthPlaying) {
      _startAutoGrowth();
    }

    HapticFeedback.lightImpact();
  }

  void _startAutoGrowth() {
    if (!_isGrowthPlaying) return;

    Future.delayed(Duration(seconds: 1), () {
      if (_isGrowthPlaying && _cropAge < crops[_selectedCropIndex]['days']) {
        setState(() {
          _cropAge += 1;
          _updateCropHealth();
        });
        _startAutoGrowth();
      }
    });
  }

  void _addWater() {
    setState(() {
      _soilMoisture = math.min(100, _soilMoisture + 20);
    });

    _waterController.forward().then((_) => _waterController.reset());
    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("💧 Water added! Soil moisture increased."), // CONVERTED TO ENGLISH
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addFertilizer() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🌱 Fertilizer added! Plant growth will speed up."), // CONVERTED TO ENGLISH
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addPesticide() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🛡️ Pesticide applied! Pest protection added."), // CONVERTED TO ENGLISH
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _getScenarioRecommendations() {
    Map<String, dynamic> farmData = {
      'crop_type': crops[_selectedCropIndex]['name'],
      'crop_age': _cropAge,
      'max_age': crops[_selectedCropIndex]['days'],
      'farm_size': _farmSize,
      'weather': weatherOptions[_selectedWeatherIndex]['name'],
      'season': seasons[_selectedSeasonIndex],
      'state': states[_selectedStateIndex],
      'soil_moisture': _soilMoisture,
      'temperature': _temperature,
      'health_status': _cropHealth,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScenarioRecommendationScreen(
          detectedCrop: crops[_selectedCropIndex]['name'],
          currentHealth: _cropHealth,
          analysisData: farmData,
          isVirtualFarm: true,
        ),
      ),
    );
  }

  void _resetFarm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("🔄 Reset Farm"),
        content: Text("Are you sure you want to start a new farm?"), // CONVERTED TO ENGLISH
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isFarmPlanted = false;
                _cropAge = 0;
                _isGrowthPlaying = false;
                _soilMoisture = 60.0;
                _cropHealth = "Good";
              });
              _plantGrowthController.reset();
            },
            child: Text("Reset", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSeasonPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Choose Season", // CONVERTED TO ENGLISH
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold), // INCREASED: Font size
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: seasons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(seasons[index], style: TextStyle(fontSize: 16)), // INCREASED: Font size
                    trailing: _selectedSeasonIndex == index
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedSeasonIndex = index;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Choose State", // CONVERTED TO ENGLISH
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold), // INCREASED: Font size
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: states.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(states[index], style: TextStyle(fontSize: 16)), // INCREASED: Font size
                    trailing: _selectedStateIndex == index
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedStateIndex = index;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.help, color: Colors.green),
            SizedBox(width: 8),
            Text("Virtual Farm Guide", style: TextStyle(fontSize: 18)), // INCREASED: Font size
          ],
        ),
        content: SingleChildScrollView(  // FIXED: Wrapped content in SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpItem("1️⃣", "Select weather, season, state, and crop"), // CONVERTED TO ENGLISH
              _buildHelpItem("2️⃣", "Decide farm size (in acres)"), // CONVERTED TO ENGLISH
              _buildHelpItem("3️⃣", "Press 'Plant Crop' button"), // CONVERTED TO ENGLISH
              _buildHelpItem("4️⃣", "Use growth controls to grow crop"), // CONVERTED TO ENGLISH
              _buildHelpItem("5️⃣", "Add water, fertilizer, pesticide"), // CONVERTED TO ENGLISH
              _buildHelpItem("6️⃣", "Try AI scenarios to get best results"), // CONVERTED TO ENGLISH
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), // CONVERTED TO ENGLISH
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String step, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17), // INCREASED: Font size
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(fontSize: 15), // INCREASED: Font size
            ),
          ),
        ],
      ),
    );
  }
}

extension on Color {
  Color? get shade700 => null;
}

// Custom painters for weather effects (unchanged)
class RainPainter extends CustomPainter {
  final double animation;

  RainPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.6)
      ..strokeWidth = 2.0;

    for (int i = 0; i < 50; i++) {
      double x = (i % 10) * (size.width / 10);
      double y = (animation * size.height + i * 20) % size.height;

      canvas.drawLine(
        Offset(x, y),
        Offset(x + 5, y + 15),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SunRaysPainter extends CustomPainter {
  final double animation;

  SunRaysPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow.withOpacity(0.6)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width - 30, 30);
    final radius = 25.0;

    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi * 2) / 8 + (animation * math.pi * 2);
      final start = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      final end = Offset(
        center.dx + math.cos(angle) * (radius + 15),
        center.dy + math.sin(angle) * (radius + 15),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
