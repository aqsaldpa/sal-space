import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  SkillsSection({super.key});

  final List<Map<String, String>> skills = [
    {'name': 'Flutter/Dart', 'icon': '💎'},
    {'name': 'iOS Development', 'icon': '🍎'},
    {'name': 'Android/Kotlin', 'icon': '🤖'},
    {'name': 'Firebase', 'icon': '🔥'},
    {'name': 'REST API', 'icon': '🌐'},
    {'name': 'MVVM', 'icon': '🏗️'},
    {'name': 'Git', 'icon': '📦'},
    {'name': 'Riverpod', 'icon': '⚡'},
    {'name': 'GetX', 'icon': '🔄'},
    {'name': 'Provider', 'icon': '🔌'},
  ];

  // Skill categories for better organization
  final List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Frameworks & Languages',
      'skills': [
        {'name': 'Flutter/Dart', 'icon': '💎'},
        {'name': 'Android/Kotlin', 'icon': '🤖'},
        {'name': 'iOS Development', 'icon': '🍎'},
      ]
    },
    {
      'category': 'State Management',
      'skills': [
        {'name': 'Riverpod', 'icon': '⚡'},
        {'name': 'GetX', 'icon': '🔄'},
        {'name': 'Provider', 'icon': '🔌'},
        {'name': 'Bloc', 'icon': '🧩'},
      ]
    },
    {
      'category': 'Backend & Services',
      'skills': [
        {'name': 'Firebase', 'icon': '🔥'},
        {'name': 'REST API', 'icon': '🌐'},
        {'name': 'GraphQL', 'icon': '📊'},
      ]
    },
    {
      'category': 'Tools & Methodologies',
      'skills': [
        {'name': 'Git', 'icon': '📦'},
        {'name': 'MVVM', 'icon': '🏗️'},
        {'name': 'CI/CD', 'icon': '🔄'},
        {'name': 'Agile', 'icon': '🔄'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
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
                'Skills',
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

          // Subtitle
          Text(
            'Technologies I work with',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 40),

          // Skills by category
          ...skillCategories.map((category) => _buildSkillCategory(
              category['category'],
              List<Map<String, String>>.from(category['skills']),
              isMobile)),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
      String categoryName, List<Map<String, String>> skills, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category name
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              categoryName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          // Skills in this category
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills
                .map((skill) => _buildSkillChip(skill, isMobile))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(Map<String, String> skill, bool isMobile) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 16, vertical: isMobile ? 10 : 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(skill['icon']!, style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            skill['name']!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
