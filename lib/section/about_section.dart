import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widget/particle.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;
  late Animation<double> _rotateGradient;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Interval(0.0, 0.5, curve: Curves.easeOut)),
    );

    _slideIn = Tween<Offset>(
      begin: Offset(0, 30),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.2, 0.7, curve: Curves.easeOut)));

    _rotateGradient = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, String>> quickStats = [
    {'label': 'Years', 'value': '3+'},
    {'label': 'Apps Created', 'value': '8+'},
    {'label': 'Client Projects', 'value': '15+'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF283593),
              Color(0xFF283593),
              Color(0xFF303f9f),
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1a237e).withOpacity(0.9),
                    Color(0xFF283593).withOpacity(0.85),
                    Color(0xFF303f9f).withOpacity(0.9),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: _rotateGradient.value,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: SweepGradient(
                                  colors: [
                                    Colors.blue.shade300,
                                    Colors.purple.shade300,
                                    Colors.pink.shade300,
                                    Colors.blue.shade300,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.person,
                                size: 60, color: Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  FadeTransition(
                    opacity: _fadeIn,
                    child: SlideTransition(
                      position: _slideIn,
                      child: SelectableText(
                        'Hello, I\'m Aqsal Dharmaputra',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 700,
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: SlideTransition(
                        position: _slideIn,
                        child: SelectableText(
                          'Mobile app developer with 3+ years experience in Flutter, Dart, and Kotlin. I build clean, well-structured applications with optimized performance and polished interfaces across platforms. My development approach prioritizes maintainable architecture and efficient code, consistently delivering business value through quality solutions.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children:
                        quickStats.map((stat) => _buildStatCard(stat)).toList(),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: FloatingParticles(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(Map<String, String> stat) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          SelectableText(
            stat['value']!,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 8),
          SelectableText(
            stat['label']!,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
