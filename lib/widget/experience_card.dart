import 'package:flutter/material.dart';

class ModernExperienceCard extends StatelessWidget {
  final String title;
  final String company;
  final String period;
  final List<String> achievements;
  final bool isExpanded;
  final VoidCallback onTap;
  final bool isLast;
  final Color primaryColor;
  final Color accentColor;

  const ModernExperienceCard({
    super.key,
    required this.title,
    required this.company,
    required this.period,
    required this.achievements,
    required this.isExpanded,
    required this.onTap,
    this.isLast = false,
    this.primaryColor = const Color(0xFF0047AB), // Royal blue default
    this.accentColor = const Color(0xFF002D69), // Darker blue default
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timeline dot and line
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline component
            SizedBox(
              width: 30,
              child: Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isExpanded
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      boxShadow: isExpanded
                          ? [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              )
                            ]
                          : null,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height:
                          isExpanded ? achievements.length * 50.0 + 170 : 100.0,
                      margin: const EdgeInsets.only(top: 8),
                      color: Colors.white.withOpacity(0.2),
                    ),
                ],
              ),
            ),

            // Card content
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Card(
                  elevation: isExpanded ? 6 : 2,
                  shadowColor: isExpanded
                      ? primaryColor.withOpacity(0.4)
                      : Colors.black.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isExpanded
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                  color:
                      isExpanded ? Colors.white.withOpacity(0.1) : accentColor,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(16),
                    splashColor: Colors.white.withOpacity(0.1),
                    hoverColor: Colors.white.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row with title and period
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title.split(' - ')[0],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: isExpanded
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.white.withOpacity(0.1),
                                ),
                                child: Text(
                                  period,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Company
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 16,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  title.split(' - ').length > 1
                                      ? title.split(' - ')[1]
                                      : '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          // Location
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  company,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Expandable achievements section
                          if (isExpanded) ...[
                            const SizedBox(height: 20),
                            Divider(color: Colors.white.withOpacity(0.1)),
                            const SizedBox(height: 12),

                            // Key achievements heading
                            Text(
                              'Key Achievements',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Achievements list with modern bullets
                            ...achievements.map((achievement) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          achievement,
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1.5,
                                            color:
                                                Colors.white.withOpacity(0.85),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ] else ...[
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Click to expand',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
