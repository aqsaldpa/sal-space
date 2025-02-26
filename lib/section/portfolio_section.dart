import 'package:flutter/material.dart';
import 'package:web_portfolio/widget/project_card.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final Color _primaryBlue = const Color(0xFF0047AB);
  final Color _accentBlue = const Color(0xFF4169E1);
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'BINABOLA',
      'description':
          'A platform that supports improvement of Indonesian youth football',
      'imageAsset': 'assets/logo.png',
      'technologies': ['Flutter', 'Firebase', 'Cloud Functions'],
      'keyFeatures': [
        'Real-time match tracking',
        'Player performance analytics',
        'Training program management',
        'Talent scouting system'
      ],
    },
    {
      'title': 'FITLIFE',
      'description': 'A healthy lifestyle app that can track your diet',
      'imageAsset': 'assets/logo.png',
      'technologies': ['Flutter', 'Firebase', 'Machine Learning'],
      'keyFeatures': [
        'Personalized meal planning',
        'Calorie tracking',
        'Exercise routines',
        'Progress analytics'
      ],
    },
    {
      'title': 'SMARTECO',
      'description': 'Environmental monitoring application',
      'imageAsset': 'assets/logo.png',
      'technologies': ['Flutter', 'IoT Integration', 'Cloud Database'],
      'keyFeatures': [
        'Real-time air quality monitoring',
        'Water conservation tracking',
        'Energy usage optimization',
        'Environmental alerts'
      ],
    },
    {
      'title': 'BOOKHUB',
      'description': 'Digital library and reading platform',
      'imageAsset': 'assets/logo.png',
      'technologies': ['Flutter', 'Firebase', 'Content Management'],
      'keyFeatures': [
        'Digital book collections',
        'Reading progress sync',
        'Personalized recommendations',
        'Social reading features'
      ],
    },
    {
      'title': 'TRAVELGO',
      'description': 'Travel planning and booking application',
      'imageAsset': 'assets/logo.png',
      'technologies': ['Flutter', 'REST API', 'Maps Integration'],
      'keyFeatures': [
        'Destination discovery',
        'Itinerary planning',
        'Booking integration',
        'Travel memories'
      ],
    },
    {
      'title': 'TASKFLOW',
      'description': 'Productivity and task management app',
      'imageAsset': 'assets/logo.png',
      'technologies': ['Flutter', 'Local Database', 'Calendar Integration'],
      'keyFeatures': [
        'Task organization',
        'Progress tracking',
        'Priority management',
        'Team collaboration'
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          // Header with horizontal line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  'Portfolio',
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
          ),

          const SizedBox(height: 16),

          // Subtle description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Featured projects I\'ve built',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
                letterSpacing: 0.3,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Portfolio carousel for desktop/tablet
          if (!isMobile)
            SizedBox(
              height: 450,
              child: PageView.builder(
                controller: _pageController,
                itemCount: projects.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  // Calculate scale factor for carousel effect
                  return TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: index == _currentPage ? 0.8 : 1.0,
                      end: index == _currentPage ? 1.0 : 0.8,
                    ),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutQuint,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: index == _currentPage ? 1.0 : 0.6,
                          child: ImprovedProjectCard(
                            title: projects[index]['title'],
                            description: projects[index]['description'],
                            imageAsset: projects[index]['imageAsset'],
                            technologies: List<String>.from(
                                projects[index]['technologies']),
                            keyFeatures: List<String>.from(
                                projects[index]['keyFeatures']),
                            primaryColor: _primaryBlue,
                            accentColor: _accentBlue,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          // Grid layout for mobile - FIXED CENTERING ISSUES
          else
            Center(
              // Added explicit Center widget
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500), // Add constraints
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 20,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) => ImprovedProjectCard(
                    title: projects[index]['title'],
                    description: projects[index]['description'],
                    imageAsset: projects[index]['imageAsset'],
                    technologies:
                        List<String>.from(projects[index]['technologies']),
                    keyFeatures:
                        List<String>.from(projects[index]['keyFeatures']),
                    isMobile: true,
                    primaryColor: _primaryBlue,
                    accentColor: _accentBlue,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 32),

          // Pagination indicators
          if (!isMobile)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  projects.length,
                  (index) => GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
