
// saved_scenarios_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class SavedScenariosScreen extends StatefulWidget {
  @override
  _SavedScenariosScreenState createState() => _SavedScenariosScreenState();
}

class _SavedScenariosScreenState extends State<SavedScenariosScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Filter options
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Wheat', 'Rice', 'Cotton', 'Maize'];

  // Demo saved scenarios data
  List<Map<String, dynamic>> _savedScenarios = [
    {
      'id': 1,
      'title': 'Wheat Farm - Punjab',
      'cropType': 'Wheat',
      'cropEmoji': '🌾',
      'location': 'Punjab',
      'weather': 'Sunny',
      'season': 'Winter',
      'farmSize': 2.5,
      'expectedYield': '12.5 tons',
      'createdDate': '2024-01-15',
      'status': 'Excellent',
      'progress': 85,
      'daysLeft': 15,
      'lastUpdated': '2 days ago',
      'recommendations': [
        'Apply fertilizer in next 5 days',
        'Monitor soil moisture levels',
        'Prepare for harvest in 2 weeks'
      ],
      'color': Colors.amber,
    },
    {
      'id': 2,
      'title': 'Rice Paddy - Haryana',
      'cropType': 'Rice',
      'cropEmoji': '🌾',
      'location': 'Haryana',
      'weather': 'Rainy',
      'season': 'Monsoon',
      'farmSize': 3.0,
      'expectedYield': '18.0 tons',
      'createdDate': '2024-01-10',
      'status': 'Good',
      'progress': 70,
      'daysLeft': 30,
      'lastUpdated': '1 day ago',
      'recommendations': [
        'Check water levels regularly',
        'Apply organic pesticide',
        'Monitor for pest attacks'
      ],
      'color': Colors.green,
    },
    {
      'id': 3,
      'title': 'Cotton Field - Maharashtra',
      'cropType': 'Cotton',
      'cropEmoji': '🌿',
      'location': 'Maharashtra',
      'weather': 'Cloudy',
      'season': 'Summer',
      'farmSize': 4.5,
      'expectedYield': '13.5 tons',
      'createdDate': '2024-01-05',
      'status': 'Fair',
      'progress': 60,
      'daysLeft': 45,
      'lastUpdated': '3 days ago',
      'recommendations': [
        'Increase watering frequency',
        'Add potassium fertilizer',
        'Check for bollworm infestation'
      ],
      'color': Colors.lightGreen,
    },
    {
      'id': 4,
      'title': 'Maize Crop - Karnataka',
      'cropType': 'Maize',
      'cropEmoji': '🌽',
      'location': 'Karnataka',
      'weather': 'Sunny',
      'season': 'Summer',
      'farmSize': 1.8,
      'expectedYield': '10.8 tons',
      'createdDate': '2024-01-20',
      'status': 'Excellent',
      'progress': 90,
      'daysLeft': 8,
      'lastUpdated': '1 hour ago',
      'recommendations': [
        'Ready for harvest soon',
        'Check grain moisture content',
        'Arrange harvesting equipment'
      ],
      'color': Colors.yellow,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredScenarios = _getFilteredScenarios();

    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Filter bar
              _buildFilterBar(),

              // Scenarios list
              Expanded(
                child: filteredScenarios.isEmpty
                    ? _buildEmptyState()
                    : _buildScenariosList(filteredScenarios),
              ),
            ],
          ),
        ),
      ),

      // Floating action button to create new scenario
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewScenario,
        backgroundColor: Colors.green.shade600,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "New Scenario",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
          colors: [Colors.green.shade400, Colors.green.shade600],
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
                      "📋 Saved Scenarios",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your farming experiments & results",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              // Search button
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.search, color: Colors.white, size: 22),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem("Total", "${_savedScenarios.length}", Icons.folder),
              _buildStatItem("Active", "${_getActiveScenarios()}", Icons.trending_up),
              _buildStatItem("Completed", "${_getCompletedScenarios()}", Icons.check_circle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          String filter = _filterOptions[index];
          bool isSelected = _selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
              HapticFeedback.lightImpact();
            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [Colors.green.shade400, Colors.green.shade600],
                      )
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.green.shade300,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScenariosList(List<Map<String, dynamic>> scenarios) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: scenarios.length,
      itemBuilder: (context, index) {
        return _buildScenarioCard(scenarios[index]);
      },
    );
  }

  Widget _buildScenarioCard(Map<String, dynamic> scenario) {
    return GestureDetector(
      onTap: () => _openScenarioDetails(scenario),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
          children: [
            // Header row
            Row(
              children: [
                // Crop emoji and info
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scenario['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    scenario['cropEmoji'],
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scenario['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            scenario['location'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 16),
                          Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            scenario['lastUpdated'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(scenario['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _getStatusColor(scenario['status']).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    scenario['status'],
                    style: TextStyle(
                      color: _getStatusColor(scenario['status']),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress: ${scenario['progress']}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${scenario['daysLeft']} days left",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: scenario['progress'] / 100,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(scenario['color']),
                  minHeight: 6,
                ),
              ],
            ),

            SizedBox(height: 16),

            // Details row
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem("🌾 Crop", scenario['cropType']),
                ),
                Expanded(
                  child: _buildDetailItem("📏 Farm Size", "${scenario['farmSize']} acres"),
                ),
                Expanded(
                  child: _buildDetailItem("🎯 Expected", scenario['expectedYield']),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Action buttons row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _viewDetails(scenario),
                    icon: Icon(Icons.visibility, size: 16),
                    label: Text("View Details"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue.shade700,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),

                SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _continueScenario(scenario),
                    icon: Icon(Icons.play_arrow, size: 16),
                    label: Text("Continue"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),

                SizedBox(width: 8),

                // More options button
                GestureDetector(
                  onTap: () => _showScenarioOptions(scenario),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.more_vert,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            "No scenarios found",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Create your first farming scenario\nto get started!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _createNewScenario,
            icon: Icon(Icons.add),
            label: Text("Create New Scenario"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  List<Map<String, dynamic>> _getFilteredScenarios() {
    if (_selectedFilter == 'All') {
      return _savedScenarios;
    }
    return _savedScenarios.where((scenario) => scenario['cropType'] == _selectedFilter).toList();
  }

  int _getActiveScenarios() {
    return _savedScenarios.where((s) => s['progress'] < 100).length;
  }

  int _getCompletedScenarios() {
    return _savedScenarios.where((s) => s['progress'] >= 100).length;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
        return Colors.green;
      case 'good':
        return Colors.lightGreen;
      case 'fair':
        return Colors.orange;
      case 'needs attention':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Action methods
  void _createNewScenario() {
    HapticFeedback.mediumImpact();
    Navigator.pop(context); // Go back to create new scenario
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🌱 Navigate to Virtual Farm to create new scenario!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openScenarioDetails(Map<String, dynamic> scenario) {
    HapticFeedback.lightImpact();
    _showScenarioDetailsDialog(scenario);
  }

  void _viewDetails(Map<String, dynamic> scenario) {
    HapticFeedback.lightImpact();
    _showScenarioDetailsDialog(scenario);
  }

  void _continueScenario(Map<String, dynamic> scenario) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🚀 Continuing scenario: ${scenario['title']}"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    // Here you would navigate to the virtual farm screen with this scenario loaded
  }

  void _showScenarioOptions(Map<String, dynamic> scenario) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              scenario['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text("Edit Scenario"),
              onTap: () {
                Navigator.pop(context);
                _editScenario(scenario);
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.green),
              title: Text("Share Results"),
              onTap: () {
                Navigator.pop(context);
                _shareScenario(scenario);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy, color: Colors.orange),
              title: Text("Duplicate Scenario"),
              onTap: () {
                Navigator.pop(context);
                _duplicateScenario(scenario);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text("Delete Scenario"),
              onTap: () {
                Navigator.pop(context);
                _deleteScenario(scenario);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showScenarioDetailsDialog(Map<String, dynamic> scenario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Text(scenario['cropEmoji'], style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                scenario['title'],
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogDetailRow("📍 Location", scenario['location']),
              _buildDialogDetailRow("🌤️ Weather", scenario['weather']),
              _buildDialogDetailRow("📅 Season", scenario['season']),
              _buildDialogDetailRow("📏 Farm Size", "${scenario['farmSize']} acres"),
              _buildDialogDetailRow("🎯 Expected Yield", scenario['expectedYield']),
              _buildDialogDetailRow("📊 Progress", "${scenario['progress']}%"),
              _buildDialogDetailRow("⏰ Days Left", "${scenario['daysLeft']} days"),
              _buildDialogDetailRow("✅ Status", scenario['status']),

              SizedBox(height: 16),
              Text(
                "🔥 AI Recommendations:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              SizedBox(height: 8),
              ...scenario['recommendations'].map<Widget>((rec) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ", style: TextStyle(color: Colors.green.shade600)),
                    Expanded(child: Text(rec, style: TextStyle(fontSize: 14))),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _continueScenario(scenario);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
            ),
            child: Text("Continue Scenario", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editScenario(Map<String, dynamic> scenario) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("✏️ Edit feature coming soon!"),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareScenario(Map<String, dynamic> scenario) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("📤 Sharing: ${scenario['title']}"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _duplicateScenario(Map<String, dynamic> scenario) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("📋 Scenario duplicated successfully!"),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteScenario(Map<String, dynamic> scenario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Scenario"),
        content: Text("Are you sure you want to delete '${scenario['title']}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _savedScenarios.removeWhere((s) => s['id'] == scenario['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("🗑️ Scenario deleted successfully"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
