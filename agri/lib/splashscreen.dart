import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class FuturisticSplashScreen extends StatefulWidget {
  final Duration duration;
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final VoidCallback? onComplete;

  const FuturisticSplashScreen({
    Key? key,
    this.duration = const Duration(seconds: 3),
    this.title = 'Welcome',
    this.subtitle = 'Your Agri Buddy...',
    this.primaryColor = const Color(0xFFF3DB59),
    this.accentColor = const Color(0xFF30D827),
    this.backgroundColor = const Color(0xFFCAF2E5),
    this.onComplete,
  }) : super(key: key);

  @override
  State<FuturisticSplashScreen> createState() => _FuturisticSplashScreenState();
}

class _FuturisticSplashScreenState extends State<FuturisticSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _progressController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _progressController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // When progress completes, call onComplete callback
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      }
    });
  }

  void _startAnimations() {
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);

    Timer(const Duration(milliseconds: 300), () {
      _scaleController.forward();
    });

    Timer(const Duration(milliseconds: 600), () {
      _fadeController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      _progressController.forward();
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              widget.backgroundColor.withOpacity(0.85),
              widget.backgroundColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background particles
            ...List.generate(20, (index) => _buildParticle(index, size)),

            // Center content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated logo with ring and pulse
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _rotationAnimation,
                      _scaleAnimation,
                      _pulseAnimation,
                    ]),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value * _pulseAnimation.value,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.primaryColor.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer rotating ring
                              Transform.rotate(
                                angle: _rotationAnimation.value,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: widget.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: CustomPaint(
                                    painter: _FuturisticRingPainter(
                                      primaryColor: widget.primaryColor,
                                      accentColor: widget.accentColor,
                                      progress: _rotationAnimation.value,
                                    ),
                                  ),
                                ),
                              ),

                              // Your app logo here (replace this Icon with your own image/logo widget)
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      widget.primaryColor,
                                      widget.accentColor,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.primaryColor.withOpacity(0.5),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/IMG_3990.PNG', // <-- Replace with your logo path
                                    fit: BoxFit.contain,
                                    width: 36,
                                    height: 36,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Title text with fade animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: widget.primaryColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Subtitle text with fade animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.7),
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Progress bar with percentage
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Column(
                        children: [
                          Container(
                            width: 200,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 200 * _progressAnimation.value,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    gradient: LinearGradient(
                                      colors: [
                                        widget.primaryColor,
                                        widget.accentColor,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.primaryColor.withOpacity(0.5),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            '${(_progressAnimation.value * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticle(int index, Size size) {
    final random = math.Random(index);
    final particleSize = random.nextDouble() * 4 + 1;
    final left = random.nextDouble() * size.width;
    final top = random.nextDouble() * size.height;

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Positioned(
          left: left,
          top: top,
          child: Opacity(
            opacity: (0.3 + 0.3 * _pulseAnimation.value) * (index.isEven ? 1 : 0.5),
            child: Container(
              width: particleSize,
              height: particleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index.isEven ? widget.primaryColor : widget.accentColor,
                boxShadow: [
                  BoxShadow(
                    color: (index.isEven ? widget.primaryColor : widget.accentColor).withOpacity(0.5),
                    blurRadius: particleSize * 2,
                    spreadRadius: particleSize * 0.5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FuturisticRingPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;
  final double progress;

  _FuturisticRingPainter({
    required this.primaryColor,
    required this.accentColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    for (int i = 0; i < 8; i++) {
      final paint = Paint()
        ..color = Color.lerp(primaryColor, accentColor, i / 8)!.withOpacity(0.8)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final startAngle = (i * math.pi / 4) + (progress * math.pi / 4);
      final sweepAngle = math.pi / 6;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
