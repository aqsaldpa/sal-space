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
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Divider(color: Colors.white30),
          SizedBox(height: 16),
          SelectableText(
            '© 2025 Aqsal Dpa. All rights reserved.',
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.email, color: Colors.white70),
                onPressed: () {
                  _launchURL('mailto:aqsaldpa28@gmail.com');
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white70),
                onPressed: () {
                  _launchURL('https://www.instagram.com/aqsaldpa');
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white70),
                onPressed: () {
                  _launchURL('https://linkedin.com/in/aqsaldpa');
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.github, color: Colors.white70),
                onPressed: () {
                  _launchURL('https://github.com/aqsaldpa');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
