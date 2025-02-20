import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:web_portfolio/section/experience_section.dart';
import 'package:web_portfolio/section/about_section.dart';
import 'footer/footer.dart';
import 'header/header_link.dart';
import 'section/portfolio_section.dart';
import 'section/skills_section.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

double getResponsiveWidth(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * percentage;
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'portfolio': GlobalKey(),
    'skills': GlobalKey(),
  };
  String _activeSection = 'about';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveSection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateActiveSection() {
    if (!_scrollController.hasClients) return;

    double viewportHeight = _scrollController.position.viewportDimension;
    double scrollPosition = _scrollController.offset;

    String? maxSection;
    double maxOverlap = 0;

    for (var entry in _sectionKeys.entries) {
      final context = entry.value.currentContext;
      if (context == null) continue;

      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      final sectionStart = position.dy;
      final sectionEnd = sectionStart + box.size.height;
      final visibleStart = scrollPosition;
      final visibleEnd = scrollPosition + viewportHeight;

      final overlapStart = math.max(sectionStart, visibleStart);
      final overlapEnd = math.min(sectionEnd, visibleEnd);
      final overlap = math.max(0.0, overlapEnd - overlapStart);

      if (overlap > maxOverlap) {
        maxOverlap = overlap;
        maxSection = entry.key;
      }
    }

    if (maxSection != null && maxSection != _activeSection) {
      setState(() {
        _activeSection = maxSection!;
      });
    }
  }

  void _scrollToSection(String section) {
    final context = _sectionKeys[section]?.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    final appBarHeight = AppBar().preferredSize.height;
    final targetOffset =
        _scrollController.offset + offset.dy - appBarHeight - 16;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: const Color(0xFF1a237e),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0d1259),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Sal Space',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mobile Developer',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem('About', 'about', Icons.person),
            _buildDrawerItem('Experience', 'experience', Icons.work),
            _buildDrawerItem('Portfolio', 'portfolio', Icons.folder),
            _buildDrawerItem('Skills', 'skills', Icons.build),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, String section, IconData icon) {
    final isActive = _activeSection == section;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.white : Colors.white70, // Warna ikon berubah
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white70,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.white.withOpacity(0.1) : null,
      onTap: () {
        Navigator.pop(context);
        _scrollToSection(section);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      drawer: isMobile ? _buildDrawer() : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 80,
                backgroundColor: const Color(0xFF1a237e),
                flexibleSpace: FlexibleSpaceBar(
                  title: const SelectableText(
                    'Sal Space',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: false,
                ),
                actions: isMobile
                    ? []
                    : [
                        HeaderLink(
                            text: 'About',
                            onTap: () => _scrollToSection('about'),
                            isActive: _activeSection == 'about'),
                        HeaderLink(
                            text: 'Experience',
                            onTap: () => _scrollToSection('experience'),
                            isActive: _activeSection == 'experience'),
                        HeaderLink(
                            text: 'Portfolio',
                            onTap: () => _scrollToSection('portfolio'),
                            isActive: _activeSection == 'portfolio'),
                        HeaderLink(
                            text: 'Skills',
                            onTap: () => _scrollToSection('skills'),
                            isActive: _activeSection == 'skills'),
                        const SizedBox(width: 16),
                      ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    AboutSection(key: _sectionKeys['about']),
                    ExperienceSection(key: _sectionKeys['experience']),
                    PortfolioSection(key: _sectionKeys['portfolio']),
                    SkillsSection(key: _sectionKeys['skills']),
                    const Footer(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
