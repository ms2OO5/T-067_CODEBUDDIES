
// weather_screen_crop_overflow_fixed.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _rotationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  // Weather API configuration
  static const String API_KEY = "your_openweathermap_api_key_here"; // Replace with your API key
  static const String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  static const String FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast";

  // State management
  String _selectedState = 'Punjab';
  bool _isLoading = false;
  Map<String, dynamic>? _currentWeather;
  List<Map<String, dynamic>> _forecast = [];
  String _errorMessage = '';

  // Indian states with major agricultural cities
  final Map<String, Map<String, dynamic>> _indianStates = {
    'Punjab': {
      'cities': ['Ludhiana', 'Amritsar', 'Jalandhar', 'Patiala'],
      'mainCity': 'Ludhiana',
      'crops': ['Wheat', 'Rice', 'Cotton'],
      'icon': '🌾',
      'color': Colors.green,
    },
    'Haryana': {
      'cities': ['Gurgaon', 'Faridabad', 'Karnal', 'Panipat'],
      'mainCity': 'Karnal',
      'crops': ['Wheat', 'Rice', 'Mustard'],
      'icon': '🌾',
      'color': Colors.lightGreen,
    },
    'Uttar Pradesh': {
      'cities': ['Lucknow', 'Agra', 'Meerut', 'Kanpur'],
      'mainCity': 'Lucknow',
      'crops': ['Wheat', 'Rice', 'Sugarcane'],
      'icon': '🌽',
      'color': Colors.amber,
    },
    'Maharashtra': {
      'cities': ['Mumbai', 'Pune', 'Nagpur', 'Nashik'],
      'mainCity': 'Nagpur',
      'crops': ['Cotton', 'Sugarcane', 'Soybean'],
      'icon': '🌿',
      'color': Colors.orange,
    },
    'Karnataka': {
      'cities': ['Bangalore', 'Mysore', 'Hubli', 'Belgaum'],
      'mainCity': 'Bangalore',
      'crops': ['Rice', 'Ragi', 'Cotton'],
      'icon': '🌾',
      'color': Colors.teal,
    },
    'Gujarat': {
      'cities': ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'],
      'mainCity': 'Ahmedabad',
      'crops': ['Cotton', 'Groundnut', 'Wheat'],
      'icon': '🌿',
      'color': Colors.blue,
    },
    'Rajasthan': {
      'cities': ['Jaipur', 'Jodhpur', 'Kota', 'Bikaner'],
      'mainCity': 'Jaipur',
      'crops': ['Wheat', 'Barley', 'Mustard'],
      'icon': '🌾',
      'color': Colors.brown,
    },
    'Madhya Pradesh': {
      'cities': ['Bhopal', 'Indore', 'Gwalior', 'Jabalpur'],
      'mainCity': 'Bhopal',
      'crops': ['Wheat', 'Soybean', 'Cotton'],
      'icon': '🌽',
      'color': Colors.purple,
    },
  };

  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadWeatherData();
    _startAutoRefresh();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _fadeController.forward();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(Duration(minutes: 10), (timer) {
      if (mounted) {
        _loadWeatherData();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _rotationController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    _rotationController.repeat();

    try {
      final stateData = _indianStates[_selectedState]!;
      final city = stateData['mainCity'];

      // Fetch current weather
      final currentResponse = await http.get(
        Uri.parse('\$BASE_URL?q=\$city,IN&appid=\$API_KEY&units=metric'),
      ).timeout(Duration(seconds: 10));

      if (currentResponse.statusCode == 200) {
        _currentWeather = json.decode(currentResponse.body);

        // Fetch 5-day forecast
        final forecastResponse = await http.get(
          Uri.parse('\$FORECAST_URL?q=\$city,IN&appid=\$API_KEY&units=metric'),
        ).timeout(Duration(seconds: 10));

        if (forecastResponse.statusCode == 200) {
          final forecastData = json.decode(forecastResponse.body);
          _processForecastData(forecastData);
        }

        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('Weather data not available');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to load weather data. Using demo data.';
      });
      _loadDemoWeatherData();
    }

    _rotationController.stop();
    _rotationController.reset();
  }

  void _processForecastData(Map<String, dynamic> data) {
    _forecast.clear();
    final List<dynamic> list = data['list'];

    // Group by day and take one forecast per day
    Map<String, dynamic> dailyForecasts = {};

    for (var item in list) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      String dateKey = '\${date.year}-\${date.month}-\${date.day}';

      if (!dailyForecasts.containsKey(dateKey) && _forecast.length < 5) {
        dailyForecasts[dateKey] = item;
        _forecast.add({
          'date': date,
          'temp': item['main']['temp'].round(),
          'description': item['weather'][0]['description'],
          'icon': item['weather'][0]['icon'],
          'humidity': item['main']['humidity'],
          'windSpeed': item['wind']['speed'],
        });
      }
    }
  }

  void _loadDemoWeatherData() {
    // Demo data for when API is not available
    _currentWeather = {
      'name': _indianStates[_selectedState]!['mainCity'],
      'main': {
        'temp': 28.5,
        'feels_like': 32.1,
        'humidity': 65,
        'pressure': 1013,
      },
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01d',
        }
      ],
      'wind': {
        'speed': 3.2,
      },
      'visibility': 10000,
      'sys': {
        'sunrise': DateTime.now().millisecondsSinceEpoch ~/ 1000 - 3600,
        'sunset': DateTime.now().millisecondsSinceEpoch ~/ 1000 + 7200,
      }
    };

    _forecast = List.generate(5, (index) => {
      'date': DateTime.now().add(Duration(days: index + 1)),
      'temp': 28 + (index % 3) * 2,
      'description': ['sunny', 'partly cloudy', 'cloudy'][index % 3],
      'icon': ['01d', '02d', '03d'][index % 3],
      'humidity': 60 + (index % 2) * 10,
      'windSpeed': 3.0 + (index % 2) * 1.5,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // State selector
              _buildStateSelector(),

              // Main content
              Expanded(
                child: _isLoading
                    ? _buildLoadingState()
                    : _errorMessage.isNotEmpty
                    ? _buildErrorState()
                    : _buildWeatherContent(),
              ),
            ],
          ),
        ),
      ),

      // Refresh button
      floatingActionButton: FloatingActionButton(
        onPressed: _loadWeatherData,
        backgroundColor: Colors.blue.shade600,
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 6.28,
              child: Icon(Icons.refresh, color: Colors.white),
            );
          },
        ),
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
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🌤️ Agricultural Weather",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Live weather for better farming",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Live indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Quick stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickStat("States", "\${_indianStates.length}", Icons.location_on),
              _buildQuickStat("Updated", "Live", Icons.access_time),
              _buildQuickStat("Forecast", "5 Days", Icons.calendar_today),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateSelector() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _indianStates.keys.length,
        itemBuilder: (context, index) {
          String stateName = _indianStates.keys.toList()[index];
          Map<String, dynamic> stateData = _indianStates[stateName]!;
          bool isSelected = _selectedState == stateName;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedState = stateName;
              });
              HapticFeedback.lightImpact();
              _loadWeatherData();
            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              constraints: BoxConstraints(
                minWidth: 80,
                maxWidth: 120,
              ),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                  colors: [stateData['color'], stateData['color'].withOpacity(0.7)],
                )
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : stateData['color'].withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: stateData['color'].withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stateData['icon'],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 4),
                  Text(
                    stateName.length > 10 ? stateName.substring(0, 8) + '..' : stateName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : stateData['color'],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 6.28,
                  child: Icon(
                    Icons.cloud_download,
                    size: 60,
                    color: Colors.blue.shade300,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              "🌤️ Loading Weather Data...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Fetching live weather for \$_selectedState",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: 80,
              color: Colors.red.shade300,
            ),
            SizedBox(height: 20),
            Text(
              "⚠️ Weather Service Unavailable",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              _errorMessage,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loadWeatherData,
              icon: Icon(Icons.refresh),
              label: Text("Try Again"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    if (_currentWeather == null) return Container();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current weather card
          _buildCurrentWeatherCard(),

          SizedBox(height: 20),

          // Weather details
          _buildWeatherDetailsGrid(),

          SizedBox(height: 20),

          // Agricultural insights - FIXED: Crops overflow
          _buildAgriculturalInsights(),

          SizedBox(height: 20),

          // 5-day forecast
          _buildForecastSection(),

          SizedBox(height: 20),

          // Farming recommendations
          _buildFarmingRecommendations(),

          SizedBox(height: 80), // Extra space for FAB
        ],
      ),
    );
  }

  Widget _buildCurrentWeatherCard() {
    final weather = _currentWeather!;
    final temp = weather['main']['temp'].round();
    final description = weather['weather'][0]['description'];
    final cityName = weather['name'];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Weather info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📍 \$cityName, \$_selectedState",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "\$temp°",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        "C",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  description.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Weather icon
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getWeatherEmoji(weather['weather'][0]['icon']),
                    style: TextStyle(fontSize: 60),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Feels like \${weather['main']['feels_like'].round()}°C",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid() {
    final weather = _currentWeather!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "📊 Weather Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildDetailCard(
              "💧 Humidity",
              "\${weather['main']['humidity']}%",
              Colors.blue,
              Icons.water_drop,
            ),
            _buildDetailCard(
              "🌬️ Wind Speed",
              "\${weather['wind']['speed']} m/s",
              Colors.green,
              Icons.air,
            ),
            _buildDetailCard(
              "🎯 Pressure",
              "\${weather['main']['pressure']} hPa",
              Colors.orange,
              Icons.speed,
            ),
            _buildDetailCard(
              "👁️ Visibility",
              "\${(weather['visibility'] ?? 10000) / 1000} km",
              Colors.purple,
              Icons.visibility,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailCard(String label, String value, Color color, IconData icon) {
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
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // FIXED: Agricultural insights with proper crops display
  Widget _buildAgriculturalInsights() {
    final stateData = _indianStates[_selectedState]!;

    return Container(
      width: double.infinity, // FIXED: Full width container
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with proper wrapping
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // FIXED: Align to start
            children: [
              Text(stateData['icon'], style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Expanded( // FIXED: Wrap title in Expanded
                child: Text(
                  "🌾 Agricultural Insights",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Text(
            "Major Crops in \$_selectedState:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade600,
            ),
          ),

          SizedBox(height: 8),

          // FIXED: Crops display with proper constraints
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth, // FIXED: Use available width
                child: Column( // FIXED: Use Column instead of Wrap
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display crops in a horizontal scrollable list
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: stateData['crops'].map<Widget>((crop) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green.shade300),
                            ),
                            child: Text(
                              crop,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 12),

          _buildWeatherImpactInfo(),
        ],
      ),
    );
  }

  Widget _buildWeatherImpactInfo() {
    if (_currentWeather == null) return Container();

    final temp = _currentWeather!['main']['temp'].round();
    final humidity = _currentWeather!['main']['humidity'];
    final windSpeed = _currentWeather!['wind']['speed'];

    List<Map<String, dynamic>> insights = [];

    if (temp > 35) {
      insights.add({
        'icon': '🔥',
        'text': 'High temperature - increase irrigation',
        'type': 'warning'
      });
    } else if (temp < 10) {
      insights.add({
        'icon': '🥶',
        'text': 'Cold weather - protect sensitive plants',
        'type': 'warning'
      });
    } else {
      insights.add({
        'icon': '✅',
        'text': 'Temperature is favorable for crops',
        'type': 'good'
      });
    }

    if (humidity > 80) {
      insights.add({
        'icon': '💧',
        'text': 'High humidity - watch for diseases',
        'type': 'warning'
      });
    } else if (humidity < 40) {
      insights.add({
        'icon': '🏜️',
        'text': 'Low humidity - water more frequently',
        'type': 'info'
      });
    } else {
      insights.add({
        'icon': '✅',
        'text': 'Humidity levels are ideal',
        'type': 'good'
      });
    }

    if (windSpeed > 10) {
      insights.add({
        'icon': '💨',
        'text': 'Strong winds - use windbreaks',
        'type': 'warning'
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weather Impact:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade600,
          ),
        ),
        SizedBox(height: 8),
        ...insights.map((insight) => Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(insight['icon'], style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  insight['text'],
                  style: TextStyle(
                    fontSize: 13,
                    color: insight['type'] == 'warning'
                        ? Colors.orange.shade700
                        : insight['type'] == 'good'
                        ? Colors.green.shade700
                        : Colors.blue.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "📅 5-Day Forecast",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          child: _forecast.isEmpty
              ? Center(
            child: Text(
              "No forecast data available",
              style: TextStyle(color: Colors.grey[600]),
            ),
          )
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _forecast.length,
            itemBuilder: (context, index) {
              return _buildForecastCard(_forecast[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForecastCard(Map<String, dynamic> forecast) {
    final DateTime date = forecast['date'];
    final String dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];

    return Container(
      width: 90,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(12),
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
        children: [
          Text(
            dayName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          Text(
            "\${date.day}/\${date.month}",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            _getWeatherEmoji(forecast['icon']),
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 8),
          Text(
            "\${forecast['temp']}°C",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmingRecommendations() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.orange.shade600, size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "🔥 Smart Farming Tips",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          ..._getFarmingTips().map((tip) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("💡 ", style: TextStyle(fontSize: 16)),
                Expanded(
                  child: Text(
                    tip,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange.shade700,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  List<String> _getFarmingTips() {
    if (_currentWeather == null) return [];

    final temp = _currentWeather!['main']['temp'].round();
    final humidity = _currentWeather!['main']['humidity'];
    final description = _currentWeather!['weather'][0]['main'].toLowerCase();

    List<String> tips = [
      "Check soil moisture daily for optimal irrigation",
      "Monitor weather forecasts for fieldwork planning",
    ];

    if (description.contains('rain')) {
      tips.addAll([
        "Avoid heavy fieldwork during rain",
        "Ensure proper drainage systems",
        "Check for fungal diseases after rain",
      ]);
    } else if (description.contains('clear')) {
      tips.addAll([
        "Perfect weather for harvesting",
        "Good time for fertilizer application",
        "Ideal for crop monitoring",
      ]);
    }

    if (temp > 30) {
      tips.add("Increase irrigation during hot weather");
    } else if (temp < 15) {
      tips.add("Protect crops from cold damage");
    }

    if (humidity > 75) {
      tips.add("Watch for pest and disease activity");
    }

    return tips.take(5).toList();
  }

  String _getWeatherEmoji(String iconCode) {
    switch (iconCode) {
      case '01d':
      case '01n':
        return '☀️';
      case '02d':
      case '02n':
        return '⛅';
      case '03d':
      case '03n':
        return '☁️';
      case '04d':
      case '04n':
        return '☁️';
      case '09d':
      case '09n':
        return '🌧️';
      case '10d':
      case '10n':
        return '🌦️';
      case '11d':
      case '11n':
        return '⛈️';
      case '13d':
      case '13n':
        return '❄️';
      case '50d':
      case '50n':
        return '🌫️';
      default:
        return '🌤️';
    }
  }
}
