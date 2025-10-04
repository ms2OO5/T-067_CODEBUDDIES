
// scenario_recommendation_screen_english_readable.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

class ScenarioRecommendationScreen extends StatefulWidget {
  final String detectedCrop;
  final String currentHealth;
  final Map<String, dynamic> analysisData;
  final bool isVirtualFarm;

  const ScenarioRecommendationScreen({
    Key? key,
    required this.detectedCrop,
    required this.currentHealth,
    required this.analysisData,
    this.isVirtualFarm = false,
  }) : super(key: key);

  @override
  _ScenarioRecommendationScreenState createState() => _ScenarioRecommendationScreenState();
}

class _ScenarioRecommendationScreenState extends State<ScenarioRecommendationScreen>
    with TickerProviderStateMixin {

  // Animation Controllers
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  // State variables
  String? _selectedScenario;
  Map<String, dynamic>? _aiRecommendation;
  bool _isLoadingRecommendation = false;
  List<Map<String, dynamic>> _scenarioHistory = [];

  // 🔥 FLASK AI SCENARIO MODEL URLS - PASTE YOUR URLs HERE
  static const String SCENARIO_RECOMMENDATION_URL = "http://your-flask-server.com/recommend-scenarios";
  static const String SCENARIO_ANALYSIS_URL = "http://your-flask-server.com/analyze-scenario";
  static const String SCENARIO_COMPARISON_URL = "http://your-flask-server.com/compare-scenarios";

  // Demo mode for testing
  static const bool USE_DEMO_MODE = true; // Set false when Flask server is ready

  // Available scenarios with detailed info - CONVERTED TO ENGLISH
  final List<Map<String, dynamic>> scenarios = [
    {
      'id': 'increase_water',
      'name': '💧 Increase Water',
      'description': 'Improve crop health by increasing soil moisture',
      'icon': Icons.water_drop,
      'color': Colors.blue,
      'difficulty': 'Easy',
      'timeRequired': '1-2 days',
      'costImpact': 'Low',
    },
    {
      'id': 'add_fertilizer',
      'name': '🌱 Add Fertilizer',
      'description': 'Boost growth rate by supplying nutrients',
      'icon': Icons.eco,
      'color': Colors.green,
      'difficulty': 'Medium',
      'timeRequired': '3-5 days',
      'costImpact': 'Medium',
    },
    {
      'id': 'pest_control',
      'name': '🛡️ Pest Control',
      'description': 'Protect crops with pesticide spray',
      'icon': Icons.shield,
      'color': Colors.orange,
      'difficulty': 'Medium',
      'timeRequired': '2-3 days',
      'costImpact': 'Medium',
    },
    {
      'id': 'change_weather',
      'name': '🌤️ Weather Control',
      'description': 'Optimize weather with greenhouse or shade net',
      'icon': Icons.wb_sunny,
      'color': Colors.yellow,
      'difficulty': 'Hard',
      'timeRequired': '1-2 weeks',
      'costImpact': 'High',
    },
    {
      'id': 'early_harvest',
      'name': '✂️ Early Harvest',
      'description': 'Harvest early to avoid weather damage',
      'icon': Icons.cut,
      'color': Colors.red,
      'difficulty': 'Easy',
      'timeRequired': '1 day',
      'costImpact': 'Low',
    },
    {
      'id': 'wait_longer',
      'name': '⏳ Wait Longer',
      'description': 'Allow more time for full maturity',
      'icon': Icons.schedule,
      'color': Colors.purple,
      'difficulty': 'Easy',
      'timeRequired': '1-4 weeks',
      'costImpact': 'None',
    },
    {
      'id': 'soil_treatment',
      'name': '🌍 Soil Treatment',
      'description': 'Balance soil pH and nutrients',
      'icon': Icons.landscape,
      'color': Colors.brown,
      'difficulty': 'Hard',
      'timeRequired': '1-2 weeks',
      'costImpact': 'High',
    },
    {
      'id': 'companion_planting',
      'name': '👥 Companion Plants',
      'description': 'Try mixed farming with companion crops',
      'icon': Icons.group,
      'color': Colors.teal,
      'difficulty': 'Medium',
      'timeRequired': '2-3 weeks',
      'costImpact': 'Medium',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _getInitialRecommendations();
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

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: LayoutBuilder( // ULTRA FIX: Add LayoutBuilder for screen constraint awareness
        builder: (context, constraints) {
          return Stack(
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade50,
                      Colors.green.shade50,
                    ],
                  ),
                ),
              ),

              // ULTRA FIX: Use MediaQuery for dynamic height calculation
              SafeArea(
                child: Column(
                  children: [
                    // Header - ULTRA FIX: Dynamic height based on screen size
                    Container(
                      height: constraints.maxHeight < 600
                          ? constraints.maxHeight * 0.25  // 25% on small screens
                          : constraints.maxHeight * 0.28, // 28% on larger screens
                      child: _buildHeader(constraints),
                    ),

                    // Content - ULTRA FIX: Remaining space
                    Expanded(
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildMainContent(constraints),
                      ),
                    ),
                  ],
                ),
              ),

              // Loading overlay
              if (_isLoadingRecommendation) _buildLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
    // ULTRA FIX: Calculate responsive sizes
    final bool isSmallScreen = constraints.maxWidth < 360;
    final bool isVerySmallScreen = constraints.maxHeight < 600;

    return Container(
      padding: EdgeInsets.fromLTRB(
          isSmallScreen ? 12 : 16,
          isVerySmallScreen ? 8 : 16,
          isSmallScreen ? 12 : 16,
          isVerySmallScreen ? 12 : 20
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple.shade400, Colors.purple.shade600],
        ),
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(isSmallScreen ? 20 : 25)
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top bar - ULTRA FIX: Dynamic height
          Container(
            height: isVerySmallScreen ? 32 : 40,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 10),
                    ),
                    child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: isSmallScreen ? 16 : 20
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "🧪 AI Scenarios", // KEPT IN ENGLISH
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 16 : (isVerySmallScreen ? 18 : 20), // INCREASED FONT SIZE
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 6 : 8,
                      vertical: isSmallScreen ? 3 : 4
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
                  ),
                  child: Text(
                    widget.isVirtualFarm ? "Virtual" : "Real Farm",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 10 : 12 // INCREASED FONT SIZE
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: isVerySmallScreen ? 8 : 16),

          // Crop info card - ULTRA FIX: Flexible height
          Expanded(
            child: Container(
              padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Main row - ULTRA FIX: Flexible height
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
                          ),
                          child: Icon(
                              Icons.agriculture,
                              color: Colors.white,
                              size: isSmallScreen ? 16 : 20
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.detectedCrop,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 13 : 16, // INCREASED FONT SIZE
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(height: 2),
                              Flexible(
                                child: Text(
                                  "Current Health: ${widget.currentHealth}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: isSmallScreen ? 11 : 14, // INCREASED FONT SIZE
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildHealthIndicator(widget.currentHealth, isSmallScreen),
                      ],
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 6 : 10),

                  // Quick stats - ULTRA FIX: Flexible height
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: _buildQuickStat("Age", "${widget.analysisData['crop_age'] ?? '0'} days", isSmallScreen)),
                        Expanded(child: _buildQuickStat("Size", "${widget.analysisData['farm_size'] ?? '1.0'} acres", isSmallScreen)),
                        Expanded(child: _buildQuickStat("Weather", _getWeatherEmoji(widget.analysisData['weather']), isSmallScreen)),
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

  Widget _buildHealthIndicator(String health, bool isSmallScreen) {
    Color color;
    IconData icon;

    switch (health.toLowerCase()) {
      case 'excellent':
        color = Colors.green;
        icon = Icons.favorite;
        break;
      case 'good':
        color = Colors.lightGreen;
        icon = Icons.thumb_up;
        break;
      case 'fair':
        color = Colors.orange;
        icon = Icons.warning;
        break;
      default:
        color = Colors.red;
        icon = Icons.error;
    }

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(isSmallScreen ? 4 : 6),
      ),
      child: Icon(icon, color: Colors.white, size: isSmallScreen ? 12 : 16),
    );
  }

  Widget _buildQuickStat(String label, String value, bool isSmallScreen) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 12 : 16, // INCREASED FONT SIZE
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: isSmallScreen ? 1 : 2),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: isSmallScreen ? 9 : 12, // INCREASED FONT SIZE
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BoxConstraints constraints) {
    final bool isSmallScreen = constraints.maxWidth < 360;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI recommendation section
          if (_aiRecommendation != null) _buildAIRecommendationCard(isSmallScreen),

          if (_aiRecommendation != null) SizedBox(height: isSmallScreen ? 12 : 16),

          // Instruction card
          _buildInstructionCard(isSmallScreen),

          SizedBox(height: isSmallScreen ? 12 : 16),

          // Scenarios grid
          _buildScenariosGrid(constraints),

          SizedBox(height: isSmallScreen ? 12 : 16),

          // Scenario history (if any)
          if (_scenarioHistory.isNotEmpty) _buildScenarioHistory(isSmallScreen),

          SizedBox(height: isSmallScreen ? 12 : 16),

          // Action buttons
          _buildActionButtons(isSmallScreen),

          SizedBox(height: 20), // Extra padding at bottom
        ],
      ),
    );
  }

  Widget _buildAIRecommendationCard(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade50, Colors.green.shade100],
        ),
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
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
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                          Icons.psychology,
                          color: Colors.white,
                          size: isSmallScreen ? 12 : 16
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: isSmallScreen ? 8 : 10),
              Expanded(
                child: Text(
                  "🤖 AI Recommendation", // CONVERTED TO ENGLISH
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 18, // INCREASED FONT SIZE
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: isSmallScreen ? 8 : 12),

          // Best case scenario
          _buildScenarioResult(
            "✅ Best Case Result:",
            _aiRecommendation!['best_case'] ?? "Enhanced crop yield and quality",
            Colors.green,
            isSmallScreen,
          ),

          SizedBox(height: isSmallScreen ? 6 : 8),

          // Worst case scenario
          _buildScenarioResult(
            "⚠️ Worst Case Result:",
            _aiRecommendation!['worst_case'] ?? "Possible crop damage or loss",
            Colors.red,
            isSmallScreen,
          ),

          SizedBox(height: isSmallScreen ? 6 : 8),

          // AI solution
          _buildScenarioResult(
            "💡 AI Solution:",
            _aiRecommendation!['solution'] ?? "Follow recommended farming practices",
            Colors.blue,
            isSmallScreen,
          ),

          SizedBox(height: isSmallScreen ? 8 : 12),

          // Confidence level
          if (_aiRecommendation!['confidence'] != null)
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
              ),
              child: Row(
                children: [
                  Icon(
                      Icons.trending_up,
                      color: Colors.green.shade600,
                      size: isSmallScreen ? 12 : 16
                  ),
                  SizedBox(width: isSmallScreen ? 4 : 6),
                  Expanded(
                    child: Text(
                      "AI Confidence: ${_aiRecommendation!['confidence']}%",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                        fontSize: isSmallScreen ? 12 : 16, // INCREASED FONT SIZE
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScenarioResult(String title, String description, Color color, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color.shade700 ?? color,
              fontSize: isSmallScreen ? 12 : 14, // INCREASED FONT SIZE
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: isSmallScreen ? 3 : 4),
          Text(
            description,
            style: TextStyle(
              color: Colors.black87,
              fontSize: isSmallScreen ? 11 : 14, // INCREASED FONT SIZE
            ),
            maxLines: isSmallScreen ? 2 : 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionCard(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade600,
                  size: isSmallScreen ? 14 : 18 // INCREASED ICON SIZE
              ),
              SizedBox(width: isSmallScreen ? 4 : 6),
              Expanded(
                child: Text(
                  "📋 How to Use?", // CONVERTED TO ENGLISH
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 16, // INCREASED FONT SIZE
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 6 : 8),
          Text(
            "• Choose any scenario from the options below\n" // CONVERTED TO ENGLISH
                "• AI will provide detailed analysis\n"
                "• Review best and worst case scenarios\n"
                "• Follow smart recommendations",
            style: TextStyle(
              fontSize: isSmallScreen ? 11 : 14, // INCREASED FONT SIZE
              color: Colors.blue.shade800,
              height: 1.3,
            ),
            maxLines: isSmallScreen ? 3 : 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildScenariosGrid(BoxConstraints constraints) {
    final bool isSmallScreen = constraints.maxWidth < 360;
    final bool isVerySmallScreen = constraints.maxWidth < 320;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🎯 Available Scenarios", // KEPT IN ENGLISH
          style: TextStyle(
            fontSize: isSmallScreen ? 15 : 18, // INCREASED FONT SIZE
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: isSmallScreen ? 8 : 12),

        // ULTRA FIX: Dynamic grid with responsive sizing
        LayoutBuilder(
          builder: (context, gridConstraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isVerySmallScreen ? 1 : 2, // Single column on very small screens
                childAspectRatio: isVerySmallScreen ? 1.2 : (isSmallScreen ? 0.9 : 0.85),
                crossAxisSpacing: isSmallScreen ? 6 : 10,
                mainAxisSpacing: isSmallScreen ? 6 : 10,
              ),
              itemCount: scenarios.length,
              itemBuilder: (context, index) {
                final scenario = scenarios[index];
                final isSelected = _selectedScenario == scenario['id'];

                return GestureDetector(
                  onTap: () => _selectScenario(scenario),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isSelected
                            ? [scenario['color'], scenario['color'].withOpacity(0.7)]
                            : [Colors.white, Colors.grey.shade50],
                      ),
                      borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                      border: Border.all(
                        color: isSelected
                            ? scenario['color']
                            : Colors.grey.shade300,
                        width: isSmallScreen ? 1.5 : 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? scenario['color'].withOpacity(0.3)
                              : Colors.grey.withOpacity(0.1),
                          spreadRadius: isSelected ? 1 : 0,
                          blurRadius: isSelected ? 4 : 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                          decoration: BoxDecoration(
                            color: (isSelected ? Colors.white : scenario['color'])
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
                          ),
                          child: Icon(
                            scenario['icon'],
                            color: isSelected ? Colors.white : scenario['color'],
                            size: isSmallScreen ? 18 : 24,
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 6 : 8),

                        // Title
                        Flexible(
                          child: Text(
                            scenario['name'],
                            style: TextStyle(
                              fontSize: isSmallScreen ? 11 : 14, // INCREASED FONT SIZE
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 4 : 6),

                        // Description
                        Flexible(
                          child: Text(
                            scenario['description'],
                            style: TextStyle(
                              fontSize: isSmallScreen ? 9 : 12, // INCREASED FONT SIZE
                              color: isSelected
                                  ? Colors.white.withOpacity(0.9)
                                  : Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Spacer(),

                        // Info tags
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoTag(
                                scenario['difficulty'],
                                isSelected ? Colors.white : Colors.grey[600]!,
                                isSelected,
                                isSmallScreen,
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: _buildInfoTag(
                                scenario['costImpact'],
                                isSelected ? Colors.white : Colors.grey[600]!,
                                isSelected,
                                isSmallScreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoTag(String text, Color color, bool isSelected, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 3 : 4,
          vertical: isSmallScreen ? 1 : 2
      ),
      decoration: BoxDecoration(
        color: (isSelected ? Colors.white : Colors.grey.shade200)
            .withOpacity(0.3),
        borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSmallScreen ? 7 : 9, // INCREASED FONT SIZE
          color: color,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildScenarioHistory(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "📊 Previous Scenarios", // KEPT IN ENGLISH
          style: TextStyle(
            fontSize: isSmallScreen ? 15 : 18, // INCREASED FONT SIZE
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: isSmallScreen ? 6 : 10),
        Container(
          height: isSmallScreen ? 80 : 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _scenarioHistory.length,
            itemBuilder: (context, index) {
              final scenario = _scenarioHistory[index];
              return Container(
                width: isSmallScreen ? 140 : 160,
                margin: EdgeInsets.only(right: isSmallScreen ? 6 : 10),
                padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      scenario['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 10 : 12 // INCREASED FONT SIZE
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isSmallScreen ? 2 : 4),
                    Expanded(
                      child: Text(
                        "Result: ${scenario['result']}",
                        style: TextStyle(
                            fontSize: isSmallScreen ? 9 : 11, // INCREASED FONT SIZE
                            color: Colors.grey[600]
                        ),
                        maxLines: isSmallScreen ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      scenario['timestamp'],
                      style: TextStyle(
                          fontSize: isSmallScreen ? 7 : 9, // INCREASED FONT SIZE
                          color: Colors.grey[500]
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isSmallScreen) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Get AI Analysis button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedScenario != null ? _getAIAnalysis : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade600,
              padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 12 : 16), // INCREASED PADDING
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                      Icons.psychology,
                      color: Colors.white,
                      size: isSmallScreen ? 16 : 20 // INCREASED ICON SIZE
                  ),
                  SizedBox(width: isSmallScreen ? 6 : 8),
                  Text(
                    _selectedScenario != null
                        ? "🤖 Get AI Analysis"  // CONVERTED TO ENGLISH
                        : "First Select Scenario", // CONVERTED TO ENGLISH
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 16, // INCREASED FONT SIZE
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: isSmallScreen ? 6 : 10),

        // Compare scenarios button
        if (_scenarioHistory.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _compareScenarios,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue.shade400),
                padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 12 : 16), // INCREASED PADDING
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                        Icons.compare,
                        color: Colors.blue.shade600,
                        size: isSmallScreen ? 16 : 20 // INCREASED ICON SIZE
                    ),
                    SizedBox(width: isSmallScreen ? 6 : 8),
                    Text(
                      "📊 Compare Scenarios", // CONVERTED TO ENGLISH
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 16, // INCREASED FONT SIZE
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  strokeWidth: 3,
                ),
                SizedBox(height: 16),
                Text(
                  "🤖 AI Analysis in Progress...", // CONVERTED TO ENGLISH
                  style: TextStyle(
                    fontSize: 16, // INCREASED FONT SIZE
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Calculating scenario results...", // CONVERTED TO ENGLISH
                  style: TextStyle(
                    fontSize: 12, // INCREASED FONT SIZE
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

  // Helper methods
  String _getWeatherEmoji(String? weather) {
    if (weather == null) return "🌤️";

    if (weather.contains("धूप") || weather.contains("Sunny")) return "☀️";
    if (weather.contains("बादल") || weather.contains("Cloudy")) return "☁️";
    if (weather.contains("बारिश") || weather.contains("Rain")) return "🌧️";
    if (weather.contains("तूफान") || weather.contains("Storm")) return "⛈️";

    return "🌤️";
  }

  // Action methods
  void _selectScenario(Map<String, dynamic> scenario) {
    setState(() {
      _selectedScenario = scenario['id'];
    });

    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Selected: ${scenario['name']}"),
        backgroundColor: scenario['color'],
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _getInitialRecommendations() async {
    if (USE_DEMO_MODE) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _aiRecommendation = _getDemoRecommendation();
      });
    } else {
      try {
        var response = await http.post(
          Uri.parse(SCENARIO_RECOMMENDATION_URL),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'crop_type': widget.detectedCrop,
            'current_health': widget.currentHealth,
            'analysis_data': widget.analysisData,
            'farm_type': widget.isVirtualFarm ? 'virtual' : 'real',
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> result = json.decode(response.body);
          setState(() {
            _aiRecommendation = result;
          });
        }
      } catch (e) {
        setState(() {
          _aiRecommendation = _getDemoRecommendation();
        });
      }
    }
  }

  Map<String, dynamic> _getDemoRecommendation() {
    String health = widget.currentHealth.toLowerCase();

    if (health.contains("excellent")) {
      return {
        'recommended_scenario': 'wait_longer',
        'confidence': 92,
        'best_case': 'Maximum yield achieved with premium quality crop. Market value will be 15-20% higher than average.',
        'worst_case': 'Over-ripening might reduce shelf life slightly. Weather damage risk if delayed too long.',
        'solution': 'Continue current care routine. Monitor weather forecast. Harvest when 95% maturity is reached.',
      };
    } else if (health.contains("good")) {
      return {
        'recommended_scenario': 'add_fertilizer',
        'confidence': 87,
        'best_case': 'Crop health will improve to excellent level. 10-15% yield increase expected within 2 weeks.',
        'worst_case': 'Over-fertilization might cause leaf burn. Temporary growth slowdown possible.',
        'solution': 'Apply balanced NPK fertilizer as per soil test. Use organic compost for sustained growth.',
      };
    } else {
      return {
        'recommended_scenario': 'increase_water',
        'confidence': 89,
        'best_case': 'Rapid health recovery within 3-5 days. Reduced stress will improve overall plant vigor.',
        'worst_case': 'Over-watering might cause root rot. Fungal diseases risk in humid conditions.',
        'solution': 'Increase irrigation frequency by 30%. Check soil moisture daily. Ensure proper drainage.',
      };
    }
  }

  Future<void> _getAIAnalysis() async {
    if (_selectedScenario == null) return;

    setState(() {
      _isLoadingRecommendation = true;
    });

    try {
      if (USE_DEMO_MODE) {
        await Future.delayed(Duration(seconds: 2));

        Map<String, dynamic> analysis = _getDemoScenarioAnalysis(_selectedScenario!);

        setState(() {
          _aiRecommendation = analysis;
          _isLoadingRecommendation = false;
        });

        _addToHistory(analysis);

      } else {
        var response = await http.post(
          Uri.parse(SCENARIO_ANALYSIS_URL),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'scenario_id': _selectedScenario,
            'crop_data': widget.analysisData,
            'current_health': widget.currentHealth,
            'farm_type': widget.isVirtualFarm ? 'virtual' : 'real',
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> result = json.decode(response.body);
          setState(() {
            _aiRecommendation = result;
            _isLoadingRecommendation = false;
          });

          _addToHistory(result);
        } else {
          throw Exception('Server error: ${response.statusCode}');
        }
      }

      HapticFeedback.mediumImpact();

    } catch (e) {
      setState(() {
        _isLoadingRecommendation = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Analysis error occurred: $e"), // CONVERTED TO ENGLISH
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Map<String, dynamic> _getDemoScenarioAnalysis(String scenarioId) {
    Map<String, dynamic> scenarioData = scenarios.firstWhere(
          (s) => s['id'] == scenarioId,
      orElse: () => scenarios[0],
    );

    // CONVERTED ALL DEMO ANALYSIS TO ENGLISH
    Map<String, Map<String, String>> scenarioAnalysis = {
      'increase_water': {
        'best_case': 'Soil moisture will become optimal. Plant stress will reduce and yield will increase by 20-25%. Root development will become stronger.',
        'worst_case': 'Excessive water may cause root rot. Risk of fungal diseases. Nutrient leaching problems.',
        'solution': 'Check soil moisture daily. Use drip irrigation. Improve drainage system.',
      },
      'add_fertilizer': {
        'best_case': 'Plant nutrition will become perfect. Green color will deepen. 15-30% growth rate increase.',
        'worst_case': 'Over-fertilization may burn plants. Soil pH imbalance. Environmental pollution.',
        'solution': 'Apply exact nutrients after soil test. Prefer organic fertilizers.',
      },
      'pest_control': {
        'best_case': 'Complete pest elimination. Healthy plant growth. Maximum yield potential achieved.',
        'worst_case': 'Chemical resistance may develop. Beneficial insects may also die.',
        'solution': 'Use Integrated Pest Management (IPM). Try neem oil and beneficial insects.',
      },
      'early_harvest': {
        'best_case': 'Will avoid weather damage. Quick market access. Reduced pest risk.',
        'worst_case': 'Lower yield will be obtained. Immature crop quality. May get less market price.',
        'solution': 'Check crop maturity indicators. Check weather forecast. Compare market rates.',
      },
    };

    return {
      'scenario_name': scenarioData['name'],
      'confidence': 85 + math.Random().nextInt(10),
      'best_case': scenarioAnalysis[scenarioId]?['best_case'] ?? 'Positive outcome expected',
      'worst_case': scenarioAnalysis[scenarioId]?['worst_case'] ?? 'Some risks involved',
      'solution': scenarioAnalysis[scenarioId]?['solution'] ?? 'Follow best practices',
      'estimated_time': scenarioData['timeRequired'],
      'cost_impact': scenarioData['costImpact'],
      'difficulty': scenarioData['difficulty'],
    };
  }

  void _addToHistory(Map<String, dynamic> analysis) {
    setState(() {
      _scenarioHistory.insert(0, {
        'name': analysis['scenario_name'] ?? 'Unknown Scenario',
        'result': analysis['best_case']?.substring(0, 50) ?? 'Positive outcome',
        'timestamp': DateTime.now().toString().substring(0, 16),
      });

      if (_scenarioHistory.length > 5) {
        _scenarioHistory.removeLast();
      }
    });
  }

  void _compareScenarios() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("📊 Scenario Comparison", style: TextStyle(fontSize: 16)), // INCREASED FONT SIZE
        content: Container(
          height: 200,
          width: 250,
          child: _scenarioHistory.isEmpty
              ? Text("No scenarios to compare", style: TextStyle(fontSize: 14)) // INCREASED FONT SIZE
              : ListView.builder(
            itemCount: _scenarioHistory.length,
            itemBuilder: (context, index) {
              final scenario = _scenarioHistory[index];
              return Card(
                child: ListTile(
                  title: Text(
                    scenario['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), // INCREASED FONT SIZE
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    scenario['result'],
                    style: TextStyle(fontSize: 10), // INCREASED FONT SIZE
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    scenario['timestamp'].substring(5, 16),
                    style: TextStyle(fontSize: 8, color: Colors.grey), // INCREASED FONT SIZE
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close", style: TextStyle(fontSize: 14)), // INCREASED FONT SIZE
          ),
        ],
      ),
    );
  }
}

extension on Color {
  get shade700 => null;
}
