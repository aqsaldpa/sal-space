import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Center(
        child: Container(
          width: screenWidth > 1200 ? 1200 : null,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Social links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.email_outlined,
                    url: 'mailto:aqsaldpa28@gmail.com',
                    tooltip: 'Email',
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.instagram,
                    url: 'https://www.instagram.com/aqsaldpa',
                    tooltip: 'Instagram',
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    url: 'https://linkedin.com/in/aqsaldpa',
                    tooltip: 'LinkedIn',
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.github,
                    url: 'https://github.com/aqsaldpa',
                    tooltip: 'GitHub',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Divider(color: Colors.white.withOpacity(0.1)),

              const SizedBox(height: 24),

              // Navigation links
              if (!isMobile)
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24,
                  children: [
                    _buildFooterLink('About', '#about'),
                    _buildFooterLink('Experience', '#experience'),
                    _buildFooterLink('Portfolio', '#portfolio'),
                    _buildFooterLink('Skills', '#skills'),
                  ],
                ),

              SizedBox(height: isMobile ? 0 : 24),

              // Copyright
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '© 2025 Aqsal Dpa. All rights reserved.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
            size: icon == FontAwesomeIcons.github ? 20 : 22,
          ),
          onPressed: () => _launchURL(url),
          splashRadius: 24,
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text, String anchor) {
    return InkWell(
      onTap: () {},
      hoverColor: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
        ),
      ),
    );
  }
}
