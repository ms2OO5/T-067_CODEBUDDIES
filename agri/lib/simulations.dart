
// main_farm_screen_responsive.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'camera_screen.dart';
import 'virtual_farm_screen.dart';

class MainFarmScreen extends StatefulWidget {
  @override
  _MainFarmScreenState createState() => _MainFarmScreenState();
}

class _MainFarmScreenState extends State<MainFarmScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 🔥 RESPONSIVE BREAKPOINTS
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            final isSmallHeight = screenHeight < 600;
            final isVerySmallHeight = screenHeight < 500;
            final isSmallWidth = screenWidth < 360;
            final isTablet = screenWidth > 600;
            final isLandscape = screenWidth > screenHeight;

            return FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 40.0 : (isSmallWidth ? 12.0 : 20.0),
                        vertical: isVerySmallHeight ? 8.0 : (isSmallHeight ? 12.0 : 16.0),
                      ),
                      child: Column(
                        children: [
                          // Header with dynamic height
                          _buildHeader(constraints),

                          SizedBox(height: isVerySmallHeight ? 16 : (isSmallHeight ? 24 : 32)),

                          // Main options - dynamic layout
                          Expanded(
                            child: isLandscape && !isTablet
                                ? _buildLandscapeLayout(constraints)
                                : _buildPortraitLayout(constraints),
                          ),

                          SizedBox(height: isVerySmallHeight ? 8 : 16),

                          // Bottom help text - compact on small screens
                          _buildBottomHelp(constraints),

                          SizedBox(height: isVerySmallHeight ? 8 : 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // Responsive floating action button
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxHeight < 600 || constraints.maxWidth < 360;
          return FloatingActionButton(
            onPressed: _showHelpDialog,
            backgroundColor: Colors.purple.shade400,
            mini: isSmall, // Smaller FAB for small screens
            child: Icon(
              Icons.help,
              color: Colors.white,
              size: isSmall ? 20 : 24,
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
    final screenHeight = constraints.maxHeight;
    final screenWidth = constraints.maxWidth;
    final isSmallHeight = screenHeight < 600;
    final isVerySmallHeight = screenHeight < 500;
    final isSmallWidth = screenWidth < 360;
    final isTablet = screenWidth > 600;

    return Container(
      padding: EdgeInsets.all(
          isTablet ? 24 : (isVerySmallHeight ? 12 : (isSmallHeight ? 16 : 20))
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade400, Colors.green.shade600],
        ),
        borderRadius: BorderRadius.circular(isTablet ? 25 : (isSmallWidth ? 15 : 20)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(
                isTablet ? 16 : (isVerySmallHeight ? 8 : (isSmallHeight ? 10 : 12))
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(
                  isTablet ? 20 : (isSmallWidth ? 10 : 15)
              ),
            ),
            child: Icon(
              Icons.agriculture,
              color: Colors.white,
              size: isTablet ? 36 : (isVerySmallHeight ? 20 : (isSmallHeight ? 24 : 28)),
            ),
          ),
          SizedBox(width: isTablet ? 20 : (isSmallWidth ? 8 : 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Smart Farm Simulator",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 28 : (isVerySmallHeight ? 16 : (isSmallHeight ? 18 : 22)),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isVerySmallHeight ? 2 : 4),
                Text(
                  "Learn farming with AI",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isTablet ? 18 : (isVerySmallHeight ? 12 : (isSmallHeight ? 13 : 15)),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitLayout(BoxConstraints constraints) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Instruction text
        _buildInstructionCard(constraints),

        SizedBox(height: _getSpacing(constraints, 32, 20, 16)),

        // Camera option
        _buildOptionCard(
          title: "📱 Scan Your Farm Land",
          subtitle: "Identify crops using camera",
          description: "AI technology will analyze your crops",
          icon: Icons.camera_alt,
          gradient: [Colors.green.shade400, Colors.green.shade600],
          onTap: _openCameraScreen,
          constraints: constraints,
        ),

        SizedBox(height: _getSpacing(constraints, 20, 16, 12)),

        // Virtual farm option
        _buildOptionCard(
          title: "🌱 Create Virtual Farm",
          subtitle: "Build your digital farm",
          description: "Plant any crop and experiment",
          icon: Icons.grass,
          gradient: [Colors.blue.shade400, Colors.blue.shade600],
          onTap: _openVirtualFarmScreen,
          constraints: constraints,
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BoxConstraints constraints) {
    return Column(
      children: [
        // Instruction text - more compact in landscape
        _buildInstructionCard(constraints),

        SizedBox(height: _getSpacing(constraints, 24, 16, 12)),

        // Options in a row for landscape
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _buildOptionCard(
                  title: "📱 Scan Your Farm Land",
                  subtitle: "Identify crops using camera",
                  description: "AI technology will analyze your crops",
                  icon: Icons.camera_alt,
                  gradient: [Colors.green.shade400, Colors.green.shade600],
                  onTap: _openCameraScreen,
                  constraints: constraints,
                  isCompact: true,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildOptionCard(
                  title: "🌱 Create Virtual Farm",
                  subtitle: "Build your digital farm",
                  description: "Plant any crop and experiment",
                  icon: Icons.grass,
                  gradient: [Colors.blue.shade400, Colors.blue.shade600],
                  onTap: _openVirtualFarmScreen,
                  constraints: constraints,
                  isCompact: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionCard(BoxConstraints constraints) {
    final screenHeight = constraints.maxHeight;
    final screenWidth = constraints.maxWidth;
    final isSmallHeight = screenHeight < 600;
    final isVerySmallHeight = screenHeight < 500;
    final isTablet = screenWidth > 600;
    final isLandscape = screenWidth > screenHeight;

    return Container(
      padding: EdgeInsets.all(
          isTablet ? 20 : (isVerySmallHeight ? 10 : (isSmallHeight ? 12 : 16))
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue.shade600,
            size: isTablet ? 36 : (isVerySmallHeight ? 20 : (isSmallHeight ? 24 : 28)),
          ),
          SizedBox(height: isVerySmallHeight ? 4 : 8),
          Text(
            "🌾 Start Your Farming Journey!",
            style: TextStyle(
              fontSize: isTablet ? 24 : (isVerySmallHeight ? 14 : (isSmallHeight ? 16 : 20)),
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: isVerySmallHeight ? 4 : 8),
          Text(
            isLandscape && !isTablet
                ? "Choose: Scan real farm or create virtual farm"
                : "Choose one of the options below:\n• Scan your real farm land\n• Or create a virtual farm",
            style: TextStyle(
              fontSize: isTablet ? 16 : (isVerySmallHeight ? 11 : (isSmallHeight ? 12 : 14)),
              color: Colors.blue.shade700,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: isLandscape && !isTablet ? 1 : 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
    required BoxConstraints constraints,
    bool isCompact = false,
  }) {
    final screenHeight = constraints.maxHeight;
    final screenWidth = constraints.maxWidth;
    final isSmallHeight = screenHeight < 600;
    final isVerySmallHeight = screenHeight < 500;
    final isSmallWidth = screenWidth < 360;
    final isTablet = screenWidth > 600;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: isCompact ? 100 : (isVerySmallHeight ? 80 : 120),
        ),
        padding: EdgeInsets.all(
            isTablet ? 24 : (isVerySmallHeight ? 12 : (isSmallHeight ? 16 : 20))
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(
              isTablet ? 25 : (isSmallWidth ? 15 : 20)
          ),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: isCompact
            ? _buildCompactCardContent(icon, title, subtitle, description, constraints)
            : _buildFullCardContent(icon, title, subtitle, description, constraints),
      ),
    );
  }

  Widget _buildFullCardContent(
      IconData icon,
      String title,
      String subtitle,
      String description,
      BoxConstraints constraints
      ) {
    final screenHeight = constraints.maxHeight;
    final screenWidth = constraints.maxWidth;
    final isSmallHeight = screenHeight < 600;
    final isVerySmallHeight = screenHeight < 500;
    final isTablet = screenWidth > 600;

    return Row(
      children: [
        // Icon container
        Container(
          padding: EdgeInsets.all(
              isTablet ? 20 : (isVerySmallHeight ? 10 : (isSmallHeight ? 12 : 16))
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
                isTablet ? 20 : (isVerySmallHeight ? 10 : 15)
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isTablet ? 40 : (isVerySmallHeight ? 24 : (isSmallHeight ? 28 : 32)),
          ),
        ),

        SizedBox(width: isTablet ? 24 : (isVerySmallHeight ? 12 : 16)),

        // Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 20 : (isVerySmallHeight ? 14 : (isSmallHeight ? 16 : 18)),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isVerySmallHeight ? 2 : 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isTablet ? 16 : (isVerySmallHeight ? 12 : (isSmallHeight ? 13 : 15)),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (!isVerySmallHeight) ...[
                SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: isTablet ? 14 : (isSmallHeight ? 11 : 12),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),

        // Arrow icon
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: isTablet ? 24 : (isVerySmallHeight ? 16 : 20),
        ),
      ],
    );
  }

  Widget _buildCompactCardContent(
      IconData icon,
      String title,
      String subtitle,
      String description,
      BoxConstraints constraints
      ) {
    final isTablet = constraints.maxWidth > 600;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: isTablet ? 36 : 28,
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: isTablet ? 12 : 11,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildBottomHelp(BoxConstraints constraints) {
    final screenHeight = constraints.maxHeight;
    final screenWidth = constraints.maxWidth;
    final isSmallHeight = screenHeight < 600;
    final isVerySmallHeight = screenHeight < 500;
    final isTablet = screenWidth > 600;

    return Container(
      padding: EdgeInsets.all(
          isTablet ? 16 : (isVerySmallHeight ? 8 : 12)
      ),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(isTablet ? 15 : 10),
        border: Border.all(color: Colors.orange.shade200, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.help_outline,
            color: Colors.orange.shade700,
            size: isTablet ? 24 : (isVerySmallHeight ? 16 : 20),
          ),
          SizedBox(width: isTablet ? 12 : 8),
          Expanded(
            child: Text(
              isVerySmallHeight
                  ? 'Voice commands: "Open Camera" or "Create Farm"'
                  : 'Need help? Use voice commands: "Open Camera" or "Create Virtual Farm"',
              style: TextStyle(
                fontSize: isTablet ? 14 : (isVerySmallHeight ? 10 : (isSmallHeight ? 11 : 13)),
                color: Colors.orange.shade800,
                fontStyle: FontStyle.italic,
                height: 1.2,
              ),
              maxLines: isVerySmallHeight ? 1 : 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for consistent spacing
  double _getSpacing(BoxConstraints constraints, double large, double medium, double small) {
    final screenHeight = constraints.maxHeight;
    if (screenHeight < 500) return small;
    if (screenHeight < 600) return medium;
    return large;
  }

  void _openCameraScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(),
      ),
    );
  }

  void _openVirtualFarmScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VirtualFarmScreen(),
      ),
    );
  }

  void _showHelpDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth > 600;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
        ),
        contentPadding: EdgeInsets.all(isTablet ? 24 : (isSmallScreen ? 16 : 20)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.help,
              color: Colors.purple,
              size: isTablet ? 28 : (isSmallScreen ? 20 : 24),
            ),
            SizedBox(width: 8),
            Text(
              "Help",
              style: TextStyle(
                fontSize: isTablet ? 22 : (isSmallScreen ? 16 : 18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 400 : 300,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHelpItem(
                  "📱 Camera Screen:",
                  "Scan your crops and get AI analysis",
                  isSmallScreen,
                  isTablet,
                ),
                _buildHelpItem(
                  "🌱 Virtual Farm:",
                  "Create digital farm and try different scenarios",
                  isSmallScreen,
                  isTablet,
                ),
                _buildHelpItem(
                  "🤖 AI Advisor:",
                  "Get smart recommendations and tips",
                  isSmallScreen,
                  isTablet,
                ),
                _buildHelpItem(
                  "🗣️ Voice Control:",
                  "Use voice commands for navigation",
                  isSmallScreen,
                  isTablet,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 20 : 16,
                vertical: isTablet ? 12 : 8,
              ),
            ),
            child: Text(
              "Got it!",
              style: TextStyle(
                fontSize: isTablet ? 16 : (isSmallScreen ? 14 : 15),
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, String description, bool isSmallScreen, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(bottom: isTablet ? 12 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 16 : (isSmallScreen ? 12 : 14),
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2),
          Text(
            description,
            style: TextStyle(
              fontSize: isTablet ? 14 : (isSmallScreen ? 11 : 13),
              color: Colors.grey[600],
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
