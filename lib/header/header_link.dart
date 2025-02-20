import 'package:flutter/material.dart';

class HeaderLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isActive;

  const HeaderLink({
    super.key,
    required this.text,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 2,
            width: isActive ? 20 : 0,
            color: isActive ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
