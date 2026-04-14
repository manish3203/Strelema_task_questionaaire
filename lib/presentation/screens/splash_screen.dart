import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/data/services/local_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _pulseController;
  late AnimationController _particleController;

  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _pulse;
  late Animation<double> _particleAnim;

  static const Color primaryPurple = Color(0xFF5F60F5);
  static const Color lightPurple = Color(0xFF8B8CF8);
  static const Color darkPurple = Color(0xFF3D3EBF);
  static const Color accentPurple = Color(0xFFB8B9FC);

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToNextScreen();
  }

  void _setupAnimations() {
    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoScale = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    );
    _logoRotation = Tween<double>(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Text animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Particle animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _particleAnim = CurvedAnimation(
      parent: _particleController,
      curve: Curves.linear,
    );

    // Start sequence
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _textController.forward();
    });
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    final storage = Get.find<LocalStorageService>();
    final bool isLoggedIn = storage.getCurrentUser() != null;
    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1B4B), // deep navy
              darkPurple,
              primaryPurple,
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // ── Floating particles ──
            AnimatedBuilder(
              animation: _particleAnim,
              builder: (_, __) => CustomPaint(
                size: size,
                painter: _ParticlePainter(_particleAnim.value),
              ),
            ),

            // ── Decorative circles ──
            Positioned(
              top: -size.width * 0.25,
              right: -size.width * 0.2,
              child: _GlowCircle(size: size.width * 0.7),
            ),
            Positioned(
              bottom: -size.width * 0.3,
              left: -size.width * 0.2,
              child: _GlowCircle(size: size.width * 0.8, opacity: 0.06),
            ),

            // ── Main content ──
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo card
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: RotationTransition(
                        turns: _logoRotation,
                        child: ScaleTransition(
                          scale: _pulse,
                          child: _LogoCard(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // App name
                  FadeTransition(
                    opacity: _textFade,
                    child: SlideTransition(
                      position: _textSlide,
                      child: Column(
                        children: [
                          const Text(
                            'Questionnaire',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              height: 1.1,
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [accentPurple, Colors.white],
                            ).createShader(bounds),
                            child: const Text(
                              'APP',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: 60,
                            height: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: const LinearGradient(
                                colors: [accentPurple, lightPurple],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Discover · Answer · Grow',
                            style: TextStyle(
                              fontSize: 13,
                              color: accentPurple,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 64),

                  // Loading indicator
                  FadeTransition(
                    opacity: _textFade,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const LinearProgressIndicator(
                              minHeight: 4,
                              backgroundColor: Color(0x33FFFFFF),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                accentPurple,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Preparing your experience...',
                          style: TextStyle(
                            color: Color(0xAAFFFFFF),
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Version tag ──
            const Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Text(
                'v1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0x55FFFFFF), fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Logo Card Widget ──────────────────────────────────────────────────────────
class _LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFE8E9FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5F60F5).withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 4,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.quiz_rounded, size: 62, color: Color(0xFF5F60F5)),
      ),
    );
  }
}

// ── Glow Circle ───────────────────────────────────────────────────────────────
class _GlowCircle extends StatelessWidget {
  final double size;
  final double opacity;
  const _GlowCircle({required this.size, this.opacity = 0.08});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(opacity),
          width: 1.5,
        ),
      ),
    );
  }
}

// ── Particle Painter ──────────────────────────────────────────────────────────
class _ParticlePainter extends CustomPainter {
  final double progress;
  static final List<_Particle> _particles = List.generate(
    18,
    (i) => _Particle(i),
  );

  _ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final dy = (p.startY - progress * p.speed) % 1.0;
      final x = p.startX * size.width;
      final y = (dy < 0 ? dy + 1.0 : dy) * size.height;

      final paint = Paint()
        ..color = Colors.white.withOpacity(p.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

class _Particle {
  final double startX;
  final double startY;
  final double speed;
  final double radius;
  final double opacity;

  _Particle(int seed)
    : startX = (seed * 0.137 + 0.05) % 1.0,
      startY = (seed * 0.273 + 0.1) % 1.0,
      speed = 0.08 + (seed % 5) * 0.04,
      radius = 1.5 + (seed % 4) * 1.2,
      opacity = 0.08 + (seed % 3) * 0.07;
}
