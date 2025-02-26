import 'package:flutter/material.dart';
import 'package:web_portfolio/widget/experience_card.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  // Brand colors based on logo
  final Color _primaryBlue = const Color(0xFF0047AB); // Royal blue from logo
  final Color _darkBlue = const Color(0xFF002D69); // Darker blue

  final List<Map<String, dynamic>> experienceData = [
    {
      'title': 'Flutter Developer - Maktabah Al-Bakri Sdn.Bhd',
      'company': 'Nilai, Negeri Sembilan, Malaysia (Hybrid)',
      'period': 'Oct 2024 - Present',
      'achievements': [
        'Successfully developed and launched Al-Inarah on Play Store & App Store, a comprehensive Flutter-based application featuring an integrated prayer times system, article, e-commerce ebook platform, digital access to Al-Quran & Al-Bayan, and premium subscription services',
        'Implemented secure payment gateway integration and completed development within 3 months using Flutter, Github, GetX & Provider frameworks, and RestAPI architecture',
        'Led software development team as project manager, orchestrating strategic timelines, coordinating regular team meetings, and facilitating progress presentations to stakeholders',
      ],
    },
    {
      'title': 'Flutter Developer - Coruja Studio',
      'company': 'Hamburg, Germany (Remote)',
      'period': 'Feb 2024 - Present',
      'achievements': [
        'Led the development of the Customer App Rent Car, incorporating features such as live car tracking, remote locking, and rental management',
        'Implemented advanced features including live map tracking, completed in 3 months using Flutter, Gitlab, Riverpod, and gRPC Service',
        'Leading the creation of the slicing design BörnTee Loyalty App to facilitate point redemption for users using Flutter and modular project architecture',
        'Developing the BörnTee POS (Point of Sales) application for cashier sales, utilizing Riverpod for state management and localization features for English and Indonesian users',
      ],
    },
    {
      'title': 'Flutter Developer - PT. Nata Connexindo',
      'company': 'Yogyakarta (On-Site)',
      'period': 'April 2023 - May 2024',
      'achievements': [
        'Developed Smart Resident Apps for Android & iOS supporting multiple user access',
        'Built applications using Flutter, Bitbucket & Github, Provider State Management, Rest API',
        'Created Lead Connection Apps for management internal sales with numerous features',
        'Contributed to feature development and bug fixing on existing apps using Kotlin',
      ],
    },
    {
      'title': 'Android Developer (Internship) - PT. Autoplastik Indonesia',
      'company': 'Karawang (On-Site)',
      'period': 'June 2022 - Jan 2023',
      'achievements': [
        'Designed and implemented the Pokayoke Mobile Apps for internal management use',
        'Developed the Planning Production Control Mobile Apps for production monitoring',
        'Built applications using Android Kotlin, MVVM architecture, and REST API',
      ],
    },
    {
      'title': 'Assistant Lecturer (Part-Time) - Amikom University',
      'company': 'Yogyakarta (On-Site)',
      'period': 'Aug 2021 - Feb 2022',
      'achievements': [
        'Served as teaching assistant for multiple courses, assisting over 130 students',
        'Assisted lecturers in designing lessons and evaluating student performance',
      ],
    },
  ];

  int _expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > 1200
        ? 1200
        : (screenWidth > 800 ? screenWidth * 0.8 : screenWidth * 0.95);

    return Container(
      width: containerWidth.toDouble(),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with horizontal line
          Row(
            children: [
              Text(
                'Experience',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Subtle description
          Text(
            'My professional journey',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 32),

          // Modern timeline with expandable cards
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: experienceData.length,
            itemBuilder: (context, index) {
              final isExpanded = _expandedIndex == index;
              return ModernExperienceCard(
                title: experienceData[index]['title'],
                company: experienceData[index]['company'],
                period: experienceData[index]['period'],
                achievements:
                    List<String>.from(experienceData[index]['achievements']),
                isExpanded: isExpanded,
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? -1 : index;
                  });
                },
                isLast: index == experienceData.length - 1,
                primaryColor: _primaryBlue,
                accentColor: _darkBlue,
              );
            },
          ),
        ],
      ),
    );
  }
}
