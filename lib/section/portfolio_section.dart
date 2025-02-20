import 'package:flutter/material.dart';

import '../widget/project_card.dart';

class PortfolioSection extends StatelessWidget {
  PortfolioSection({super.key});

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'BINABOLA',
      'description':
          'A platform that supports improvement of Indonesian youth football',
      'imageAsset': 'assets/binabola.png',
      'technologies': ['Flutter', 'Firebase', 'Cloud Functions'],
      'keyFeatures': [
        'Real-time match tracking',
        'Player performance analytics',
        'Training program management',
        'Talent scouting system'
      ],
      'width': 400.0,
    },
    {
      'title': 'FITLIFE',
      'description': 'A healthy lifestyle app that can track your diet',
      'imageAsset': 'assets/fitlife.png',
      'technologies': ['Flutter', 'Firebase', 'Machine Learning'],
      'keyFeatures': [
        'Personalized meal planning',
        'Calorie tracking',
        'Exercise routines',
        'Progress analytics'
      ],
    },
    {
      'title': 'FITLIFE',
      'description': 'A healthy lifestyle app that can track your diet',
      'imageAsset': 'assets/fitlife.png',
      'technologies': ['Flutter', 'Firebase', 'Machine Learning'],
      'keyFeatures': [
        'Personalized meal planning',
        'Calorie tracking',
        'Exercise routines',
        'Progress analytics'
      ],
    },
    {
      'title': 'FITLIFE',
      'description': 'A healthy lifestyle app that can track your diet',
      'imageAsset': 'assets/fitlife.png',
      'technologies': ['Flutter', 'Firebase', 'Machine Learning'],
      'keyFeatures': [
        'Personalized meal planning',
        'Calorie tracking',
        'Exercise routines',
        'Progress analytics'
      ],
    },
    {
      'title': 'FITLIFE',
      'description': 'A healthy lifestyle app that can track your diet',
      'imageAsset': 'assets/fitlife.png',
      'technologies': ['Flutter', 'Firebase', 'Machine Learning'],
      'keyFeatures': [
        'Personalized meal planning',
        'Calorie tracking',
        'Exercise routines',
        'Progress analytics'
      ],
    },
    {
      'title': 'FITLIFE',
      'description': 'A healthy lifestyle app that can track your diet',
      'imageAsset': 'assets/fitlife.png',
      'technologies': ['Flutter', 'Firebase', 'Machine Learning'],
      'keyFeatures': [
        'Personalized meal planning',
        'Calorie tracking',
        'Exercise routines',
        'Progress analytics'
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1a237e),
            Color(0xFF283593),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -100,
            top: 50,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.05),
                      Colors.purple.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                'Professional Experience',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 16),
              Center(
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: projects
                      .map((project) => ProjectCard(
                            title: project['title'],
                            description: project['description'],
                            imageAsset: project['imageAsset'],
                            technologies:
                                List<String>.from(project['technologies']),
                            keyFeatures:
                                List<String>.from(project['keyFeatures']),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
