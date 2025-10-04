
// farming_community_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class FarmingCommunityScreen extends StatefulWidget {
  @override
  _FarmingCommunityScreenState createState() => _FarmingCommunityScreenState();
}

class _FarmingCommunityScreenState extends State<FarmingCommunityScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Current tab
  int _currentTab = 0;
  final List<String> _tabs = ['All Posts', 'My Posts', 'Trending', 'Ask Community'];

  // Demo community posts data
  List<Map<String, dynamic>> _communityPosts = [
    {
      'id': 1,
      'userName': 'Ramesh Kumar',
      'userLocation': 'Punjab',
      'userAvatar': '👨‍🌾',
      'postTime': '2 hours ago',
      'cropType': 'Wheat',
      'cropEmoji': '🌾',
      'title': 'Amazing Wheat Yield Results!',
      'description': 'Just harvested my 5 acre wheat farm and got incredible results using the AI recommendations. Here are my findings and tips for fellow farmers.',
      'yieldResult': '25 tons from 5 acres',
      'efficiency': '95%',
      'likes': 147,
      'comments': 23,
      'shares': 8,
      'isLiked': false,
      'hasImage': true,
      'tags': ['Wheat', 'AI-Farming', 'Punjab', 'Success-Story'],
      'keyInsights': [
        'Used AI recommended fertilizer timing',
        'Monitored soil moisture daily',
        'Applied organic pesticides',
        'Perfect weather conditions'
      ],
      'helpfulTips': [
        'Start soil preparation early',
        'Use AI weather predictions',
        'Regular field monitoring is key'
      ]
    },
    {
      'id': 2,
      'userName': 'Priya Sharma',
      'userLocation': 'Haryana',
      'userAvatar': '👩‍🌾',
      'postTime': '5 hours ago',
      'cropType': 'Rice',
      'cropEmoji': '🌾',
      'title': 'Rice Farming Challenge - Need Help!',
      'description': 'I\'m facing some issues with my rice crop in the middle stage. Leaves are turning yellow. Has anyone experienced similar problems?',
      'yieldResult': 'In Progress - Day 45/120',
      'efficiency': '68%',
      'likes': 89,
      'comments': 156,
      'shares': 12,
      'isLiked': true,
      'hasImage': false,
      'tags': ['Rice', 'Help-Needed', 'Disease', 'Haryana'],
      'keyInsights': [
        'Yellow leaves appearing',
        'Growth seems slower than expected',
        'Water levels are adequate',
        'Used recommended fertilizers'
      ],
      'helpfulTips': [
        'Check for nutrient deficiency',
        'Test soil pH levels',
        'Consider organic solutions'
      ]
    },
    {
      'id': 3,
      'userName': 'Arjun Patel',
      'userLocation': 'Gujarat',
      'userAvatar': '👨‍🌾',
      'postTime': '1 day ago',
      'cropType': 'Cotton',
      'cropEmoji': '🌿',
      'title': 'Cotton Scenario: Before vs After AI',
      'description': 'Comparing my traditional farming results with AI-guided virtual scenarios. The difference is remarkable! Sharing detailed comparison.',
      'yieldResult': '18.5 tons from 8 acres',
      'efficiency': '88%',
      'likes': 234,
      'comments': 67,
      'shares': 34,
      'isLiked': false,
      'hasImage': true,
      'tags': ['Cotton', 'AI-Comparison', 'Gujarat', 'Innovation'],
      'keyInsights': [
        'AI predicted optimal planting time',
        'Reduced water usage by 30%',
        'Improved pest management',
        'Better yield than traditional methods'
      ],
      'helpfulTips': [
        'Trust AI recommendations',
        'Document your progress',
        'Share results with community'
      ]
    },
    {
      'id': 4,
      'userName': 'Sunita Devi',
      'userLocation': 'Rajasthan',
      'userAvatar': '👩‍🌾',
      'postTime': '2 days ago',
      'cropType': 'Maize',
      'cropEmoji': '🌽',
      'title': 'Drought-Resistant Maize Success',
      'description': 'Successfully grew maize in low water conditions using AI water management suggestions. Here\'s how I did it and what I learned.',
      'yieldResult': '12 tons from 3 acres',
      'efficiency': '92%',
      'likes': 189,
      'comments': 45,
      'shares': 19,
      'isLiked': true,
      'hasImage': true,
      'tags': ['Maize', 'Drought-Resistant', 'Water-Management', 'Rajasthan'],
      'keyInsights': [
        'Drip irrigation system worked perfectly',
        'AI suggested drought-resistant variety',
        'Mulching helped retain moisture',
        'Minimal water waste achieved'
      ],
      'helpfulTips': [
        'Invest in drip irrigation',
        'Choose right crop variety',
        'Monitor soil moisture constantly'
      ]
    },
    {
      'id': 5,
      'userName': 'Vikram Singh',
      'userLocation': 'Uttar Pradesh',
      'userAvatar': '👨‍🌾',
      'postTime': '3 days ago',
      'cropType': 'Sugarcane',
      'cropEmoji': '🎋',
      'title': 'First Time Using AI - Mixed Results',
      'description': 'As a beginner to AI farming, I want to share my honest experience. Some things worked great, others need improvement. Let\'s discuss!',
      'yieldResult': '45 tons from 2 acres',
      'efficiency': '76%',
      'likes': 156,
      'comments': 89,
      'shares': 15,
      'isLiked': false,
      'hasImage': false,
      'tags': ['Sugarcane', 'Beginner', 'Learning', 'Mixed-Results'],
      'keyInsights': [
        'AI planting suggestions were accurate',
        'Weather predictions helped timing',
        'Struggled with pest management',
        'Need more practice with technology'
      ],
      'helpfulTips': [
        'Start with simple AI features',
        'Ask community for help',
        'Don\'t give up - keep learning'
      ]
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
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Tab bar
              _buildTabBar(),

              // Content based on selected tab
              Expanded(
                child: _buildTabContent(),
              ),
            ],
          ),
        ),
      ),

      // Floating action button for creating new post
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewPost,
        backgroundColor: Colors.green.shade600,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Share Story",
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
                      "🌱 Farming Community",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Share experiences & learn together",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              // Notification button
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Community stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem("Members", "12.5K", Icons.people),
              _buildStatItem("Posts", "3.2K", Icons.post_add),
              _buildStatItem("Success", "89%", Icons.trending_up),
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

  Widget _buildTabBar() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          bool isSelected = _currentTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _currentTab = index;
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
                  _tabs[index],
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

  Widget _buildTabContent() {
    switch (_currentTab) {
      case 0:
        return _buildAllPostsList();
      case 1:
        return _buildMyPostsList();
      case 2:
        return _buildTrendingList();
      case 3:
        return _buildAskCommunityTab();
      default:
        return _buildAllPostsList();
    }
  }

  Widget _buildAllPostsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _communityPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(_communityPosts[index]);
      },
    );
  }

  Widget _buildMyPostsList() {
    List<Map<String, dynamic>> myPosts = _communityPosts.take(2).toList();

    return myPosts.isEmpty
        ? _buildEmptyMyPosts()
        : ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: myPosts.length,
            itemBuilder: (context, index) {
              return _buildPostCard(myPosts[index]);
            },
          );
  }

  Widget _buildTrendingList() {
    List<Map<String, dynamic>> trendingPosts = _communityPosts.where((post) => post['likes'] > 150).toList();

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: trendingPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(trendingPosts[index]);
      },
    );
  }

  Widget _buildAskCommunityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick questions section
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.help_outline, color: Colors.blue.shade600, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Ask the Community",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "Get help from experienced farmers in our community!",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue.shade600,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _askQuestion,
                  icon: Icon(Icons.question_answer, size: 16),
                  label: Text("Ask a Question"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Popular questions
          Text(
            "🔥 Popular Questions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),

          SizedBox(height: 12),

          ...["Which fertilizer works best for wheat in Punjab weather?", 
              "How to identify early signs of pest attack in rice?",
              "What\'s the optimal watering schedule for cotton?",
              "AI vs Traditional farming - which gives better yield?",
              "Best time to harvest maize for maximum profit?"]
              .map((question) => _buildQuestionCard(question))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String question) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.help, color: Colors.orange.shade600, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              question,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildEmptyMyPosts() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.post_add,
            size: 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            "No posts yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Share your farming experience\nwith the community!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _createNewPost,
            icon: Icon(Icons.add),
            label: Text("Create Your First Post"),
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

  Widget _buildPostCard(Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () => _openPostDetails(post),
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
            // User info header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    post['userAvatar'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['userName'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            post['userLocation'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            post['postTime'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Crop type badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(post['cropEmoji'], style: TextStyle(fontSize: 14)),
                      SizedBox(width: 4),
                      Text(
                        post['cropType'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Post title
            Text(
              post['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8),

            // Post description
            Text(
              post['description'],
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 16),

            // Results section
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "📊 Results",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          post['yieldResult'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${post['efficiency']} Efficiency",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Tags
            if (post['tags'] != null && post['tags'].isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: post['tags'].take(3).map<Widget>((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      "#$tag",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),

            SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                _buildActionButton(
                  Icons.thumb_up,
                  post['likes'].toString(),
                  post['isLiked'] ? Colors.blue : Colors.grey.shade600,
                  () => _toggleLike(post),
                ),
                SizedBox(width: 16),
                _buildActionButton(
                  Icons.comment_outlined,
                  post['comments'].toString(),
                  Colors.grey.shade600,
                  () => _openComments(post),
                ),
                SizedBox(width: 16),
                _buildActionButton(
                  Icons.share_outlined,
                  post['shares'].toString(),
                  Colors.grey.shade600,
                  () => _sharePost(post),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _savePost(post),
                  child: Icon(
                    Icons.bookmark_border,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String count, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Action methods
  void _createNewPost() {
    HapticFeedback.mediumImpact();
    _showCreatePostDialog();
  }

  void _askQuestion() {
    HapticFeedback.lightImpact();
    _showAskQuestionDialog();
  }

  void _toggleLike(Map<String, dynamic> post) {
    setState(() {
      post['isLiked'] = !post['isLiked'];
      if (post['isLiked']) {
        post['likes']++;
      } else {
        post['likes']--;
      }
    });
    HapticFeedback.lightImpact();
  }

  void _openComments(Map<String, dynamic> post) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("💬 Opening comments for: ${post['title']}"),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _sharePost(Map<String, dynamic> post) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("📤 Sharing: ${post['title']}"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _savePost(Map<String, dynamic> post) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🔖 Post saved to your collection"),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openPostDetails(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (context) => _buildPostDetailsDialog(post),
    );
  }

  Widget _buildPostDetailsDialog(Map<String, dynamic> post) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade600],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Text(post['cropEmoji'], style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      post['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info
                    Row(
                      children: [
                        Text(post['userAvatar'], style: TextStyle(fontSize: 20)),
                        SizedBox(width: 8),
                        Text(
                          "${post['userName']} • ${post['userLocation']}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Description
                    Text(
                      post['description'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Key insights
                    if (post['keyInsights'] != null)
                      _buildDetailSection("🔍 Key Insights", post['keyInsights']),

                    SizedBox(height: 16),

                    // Helpful tips
                    if (post['helpfulTips'] != null)
                      _buildDetailSection("💡 Helpful Tips", post['helpfulTips']),
                  ],
                ),
              ),
            ),

            // Action buttons
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDialogActionButton(
                    Icons.thumb_up,
                    "Like",
                    Colors.blue,
                    () => _toggleLike(post),
                  ),
                  _buildDialogActionButton(
                    Icons.comment,
                    "Comment",
                    Colors.green,
                    () => _openComments(post),
                  ),
                  _buildDialogActionButton(
                    Icons.share,
                    "Share",
                    Colors.orange,
                    () => _sharePost(post),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
        ),
        SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("• ", style: TextStyle(color: Colors.green.shade600)),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildDialogActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("📝 Share Your Story"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Share your farming experience with the community!",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Features coming soon:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...["📸 Add photos", "📊 Share yield results", "💡 Add tips & insights", "🏷️ Tag your post"]
                .map((feature) => Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text("• ", style: TextStyle(color: Colors.green)),
                          Text(feature, style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Later"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("🚀 Post creation feature coming soon!"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
            child: Text("Create Post", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAskQuestionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("❓ Ask the Community"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Get help from experienced farmers!",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Popular question categories:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...["🌾 Crop selection", "💧 Irrigation", "🐛 Pest control", "🌤️ Weather planning", "📊 Yield optimization"]
                .map((category) => Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text("• ", style: TextStyle(color: Colors.blue)),
                          Text(category, style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("❓ Question feature coming soon!"),
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600),
            child: Text("Ask Question", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
