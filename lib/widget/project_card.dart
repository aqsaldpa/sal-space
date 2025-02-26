import 'package:flutter/material.dart';

class ImprovedProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageAsset;
  final List<String> technologies;
  final List<String> keyFeatures;
  final bool isMobile;
  final Color primaryColor;
  final Color accentColor;

  const ImprovedProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.technologies,
    required this.keyFeatures,
    this.isMobile = false,
    this.primaryColor = const Color(0xFF0047AB), // Royal blue default
    this.accentColor = const Color(0xFF4169E1), // Royal blue lighter shade
  });

  @override
  State<ImprovedProjectCard> createState() => _ImprovedProjectCardState();
}

class _ImprovedProjectCardState extends State<ImprovedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.accentColor.withOpacity(0.3)
                  : Colors.black.withOpacity(0.1),
              blurRadius: _isHovered ? 20 : 10,
              spreadRadius: _isHovered ? 2 : 0,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 700,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.primaryColor,
                        widget.primaryColor.withOpacity(0.85),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          widget.imageAsset,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Title
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Description
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Technologies
                      Text(
                        'Technologies',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.technologies
                            .map((tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),

                      const SizedBox(height: 24),

                      // Key Features
                      Text(
                        'Key Features',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ...widget.keyFeatures.map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.9),
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),

                      const SizedBox(height: 24),

                      // Close button
                      Align(
                        alignment: Alignment.center,
                        child: TextButton.icon(
                          icon: const Icon(Icons.close),
                          label: const Text('Close'),
                          style: TextButton.styleFrom(
                            foregroundColor: widget.primaryColor,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Project image background - takes full space
                Positioned.fill(
                  child: Hero(
                    tag: widget.title,
                    child: Image.asset(
                      widget.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Custom overlay with brand color
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          widget.primaryColor.withOpacity(0.0),
                          widget.primaryColor.withOpacity(0.3),
                          widget.primaryColor.withOpacity(0.7),
                          widget.primaryColor.withOpacity(0.9),
                        ],
                        stops: const [0.4, 0.65, 0.8, 0.95],
                      ),
                    ),
                  ),
                ),

                // Project info at the bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title with animated underline on hover
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(top: 8, bottom: 12),
                          height: 2,
                          width: _isHovered ? 80 : 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        // Short description
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 16),

                        // Technology tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.technologies
                              .map((tech) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      tech,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                // View details button on hover
                if (_isHovered)
                  Positioned(
                    right: 24,
                    top: 24,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isHovered ? 1.0 : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: widget.primaryColor,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: 700,
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        widget.primaryColor,
                                        widget.primaryColor.withOpacity(0.85),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Project image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                          widget.imageAsset,
                                          height: 300,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      const SizedBox(height: 24),

                                      // Title
                                      Text(
                                        widget.title,
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      // Description
                                      Text(
                                        widget.description,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.9),
                                          height: 1.5,
                                        ),
                                      ),

                                      const SizedBox(height: 24),

                                      // Technologies
                                      Text(
                                        'Technologies',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: widget.technologies
                                            .map((tech) => Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    tech,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),

                                      const SizedBox(height: 24),

                                      // Key Features
                                      Text(
                                        'Key Features',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      ...widget.keyFeatures
                                          .map((feature) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Text(
                                                        feature,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white
                                                              .withOpacity(0.9),
                                                          height: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),

                                      const SizedBox(height: 24),

                                      // Close button
                                      Align(
                                        alignment: Alignment.center,
                                        child: TextButton.icon(
                                          icon: const Icon(Icons.close),
                                          label: const Text('Close'),
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                widget.primaryColor,
                                            backgroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
