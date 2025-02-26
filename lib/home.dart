import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/footer/footer.dart';
import 'package:web_portfolio/section/about_section.dart';
import 'package:web_portfolio/section/experience_section.dart';
import 'package:web_portfolio/section/portfolio_section.dart';
import 'package:web_portfolio/section/skills_section.dart';

const double _kMobileBreakpoint = 768;
const double _kAppBarHeight = kToolbarHeight;
const double _kScrollThreshold = 50;
const Duration _kAnimationDuration = Duration(milliseconds: 300);

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'portfolio': GlobalKey(),
    'skills': GlobalKey(),
  };

  // Brand colors based on logo
  final Color _primaryBlue = const Color(0xFF0047AB); // Royal blue from logo
  final Color _darkBlue = const Color(0xFF002D69); // Darker shade of blue

  String _activeSection = 'about';
  bool _isScrolled = false;
  bool _isThrottling = false;
  bool _isManualScrolling = false;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();

    // Initial delay to let sections render before detecting active section
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        _updateActiveSection();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      // Skip if we're manually navigating
      if (_isManualScrolling) return;

      // Throttle scroll events to reduce UI updates
      if (!_isThrottling) {
        _isThrottling = true;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            _updateActiveSection();
            _updateScrollState();
            _isThrottling = false;
          }
        });
      }
    });
  }

  void _updateScrollState() {
    final newScrollState = _scrollController.offset > _kScrollThreshold;
    if (_isScrolled != newScrollState) {
      setState(() {
        _isScrolled = newScrollState;
      });
    }
  }

  void _updateActiveSection() {
    if (!_scrollController.hasClients) return;

    // Get current scroll position plus half the viewport height for center point
    final scrollPosition = _scrollController.offset;
    final viewportHeight = _scrollController.position.viewportDimension;
    final screenCenter = scrollPosition + (viewportHeight / 2);

    // Create a map to store each section's position
    final Map<String, double> sectionPositions = {};

    // Get all sections' positions
    for (final entry in _sectionKeys.entries) {
      final context = entry.value.currentContext;
      if (context == null) continue;

      final RenderBox box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero).dy;
      final size = box.size.height;

      // Store section position (distance from top of page)
      sectionPositions[entry.key] = position;
    }

    // Find which section is currently in view
    String? newActiveSection;

    // Sort sections by position (top to bottom)
    final sortedSections = sectionPositions.keys.toList()
      ..sort((a, b) => sectionPositions[a]!.compareTo(sectionPositions[b]!));

    // Find the first section that is below the center of screen
    for (int i = 0; i < sortedSections.length; i++) {
      final thisSection = sortedSections[i];
      final thisSectionPos = sectionPositions[thisSection]!;

      // If we're at the last section or screen center is before next section
      if (i == sortedSections.length - 1 ||
          screenCenter < sectionPositions[sortedSections[i + 1]]!) {
        // If screen center is past this section
        if (screenCenter > thisSectionPos - _kAppBarHeight) {
          newActiveSection = thisSection;
        }
        break;
      }
    }

    // If we've determined a new active section and it's different from current
    if (newActiveSection != null && newActiveSection != _activeSection) {
      setState(() => _activeSection = newActiveSection!);
    }
  }

  void _scrollToSection(String section) {
    final context = _sectionKeys[section]?.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final viewport = RenderAbstractViewport.of(box);
    final revealedOffset = viewport.getOffsetToReveal(box, 0.0);

    // Set a top padding to account for the app bar
    final offset = revealedOffset.offset - _kAppBarHeight - 16;

    // Update active section immediately
    setState(() {
      _activeSection = section;
      _isManualScrolling = true;
    });

    _scrollController
        .animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    )
        .then((_) {
      // Re-enable section detection after animation completes
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            _isManualScrolling = false;
            // Force the active section to stay as selected even after scroll completes
            _activeSection = section;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < _kMobileBreakpoint;

    return Scaffold(
      drawer: isMobile ? _buildDrawer() : null,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isMobile),
      body: Container(
        // Updated gradient using the brand colors
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _primaryBlue,
              _darkBlue,
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
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
      ),
    );
  }

  // MARK: - UI Building Methods

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _primaryBlue.withOpacity(0.95),
              _darkBlue.withOpacity(0.95),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildDrawerHeader(),
            Divider(color: Colors.white.withOpacity(0.2)),
            _buildDrawerItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: EdgeInsets.all(4),
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sal Space',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Mobile Developer',
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItems() {
    return Column(
      children: [
        _buildDrawerItem('About', 'about', Icons.person_outline_rounded),
        _buildDrawerItem(
            'Experience', 'experience', Icons.work_outline_rounded),
        _buildDrawerItem('Portfolio', 'portfolio', Icons.grid_view_rounded),
        _buildDrawerItem('Skills', 'skills', Icons.auto_awesome_rounded),
      ],
    );
  }

  Widget _buildDrawerItem(String title, String section, IconData icon) {
    final isActive = _activeSection == section;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: () {
        Navigator.pop(context);
        _scrollToSection(section);
      },
    );
  }

  PreferredSize _buildAppBar(bool isMobile) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(_kAppBarHeight),
      child: AnimatedContainer(
        duration: _kAnimationDuration,
        decoration: BoxDecoration(
          color:
              _isScrolled ? _primaryBlue.withOpacity(0.98) : Colors.transparent,
          boxShadow: _isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: _buildAppBarTitle(),
          actions: isMobile ? [] : _buildDesktopNavItems(),
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Text(
          'Sal Space',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDesktopNavItems() {
    return [
      ..._sectionKeys.keys.map(
        (section) => _buildDesktopNavItem(section.capitalize(), section),
      ),
      const SizedBox(width: 24),
    ];
  }

  Widget _buildDesktopNavItem(String text, String section) {
    final isActive = _activeSection == section;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () => _scrollToSection(section),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor:
              isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: isActive
                ? BorderSide(color: Colors.white.withOpacity(0.3), width: 1)
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
