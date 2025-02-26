import 'package:flutter/material.dart';
import 'dart:ui';

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

  // Brand Colors from Logo
  final Color _primaryBlue = const Color(0xFF0047AB); // Royal blue from logo

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );
    _controller.forward();
  }

  Widget _buildProfileImage() {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipOval(
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.download_outlined, color: _primaryBlue),
          label: Text('Download CV'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Colors.white,
            foregroundColor: _primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            // Download CV logic
          },
        ),
        SizedBox(width: 16),
        _buildSocialButton(Icons.email_outlined, Colors.white),
        SizedBox(width: 12),
        _buildSocialButton(Icons.link, Colors.white),
        SizedBox(width: 12),
        _buildSocialButton(Icons.code, Colors.white),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(0.6),
          width: 2,
        ),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: color,
        onPressed: () {
          // Social link action
        },
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, bool isMobile) {
    return Container(
      width: isMobile ? 160 : 280,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            stat['icon'],
            size: 36,
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Text(
            stat['value'],
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            stat['label'],
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> quickStats = [
    {
      'label': 'Years Experience',
      'value': '3+',
      'icon': Icons.calendar_today_rounded,
    },
    {
      'label': 'Apps Created',
      'value': '8+',
      'icon': Icons.apps_rounded,
    },
    {
      'label': 'Client Projects',
      'value': '15+',
      'icon': Icons.work_outline_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 40, vertical: isMobile ? 80 : 80),
      child: Column(
        children: [
          // Profile Section
          Container(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isMobile) _buildProfileImage(),
                if (!isMobile) SizedBox(width: 60),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile) Center(child: _buildProfileImage()),
                      if (isMobile) SizedBox(height: 40),

                      // Name and title
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideIn,
                          child: isMobile
                              ? Center(
                                  child: Text(
                                    'Hello, I\'m Aqsal Dharmaputra',
                                    style: TextStyle(
                                      fontSize: isMobile ? 28 : 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                    textAlign: isMobile
                                        ? TextAlign.center
                                        : TextAlign.left,
                                  ),
                                )
                              : Text(
                                  'Hello, I\'m Aqsal Dharmaputra',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 8),

                      // Subtitle / Role
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideIn,
                          child: isMobile
                              ? Center(
                                  child: Text(
                                    'Mobile Developer',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Text(
                                  'Mobile Developer',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 24),

                      // About me description
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideIn,
                          child: Container(
                            child: Text(
                              'Mobile app developer with 3+ years experience in Flutter, Dart, and Kotlin. I build clean, well-structured applications with optimized performance and polished interfaces across platforms. My development approach prioritizes maintainable architecture and efficient code, consistently delivering business value through quality solutions.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              textAlign:
                                  isMobile ? TextAlign.center : TextAlign.left,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32),

                      // Social links and CTAs
                      FadeTransition(
                        opacity: _fadeIn,
                        child: isMobile
                            ? Center(child: _buildSocialLinks())
                            : _buildSocialLinks(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 60),

          // Stats Section
          FadeTransition(
            opacity: _fadeIn,
            child: Container(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  // Section divider
                  Row(
                    children: [
                      Text(
                        'At a Glance',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  // Stats cards
                  Center(
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: quickStats
                          .map((stat) => _buildStatCard(stat, isMobile))
                          .toList(),
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
}
