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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            'Technical Skills',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(Map<String, String> skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.2),
            Colors.purple.withOpacity(0.2),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(skill['icon']!, style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          SelectableText(
            skill['name']!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
