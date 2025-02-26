import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

void main() {
  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sal Space',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          headlineLarge: GoogleFonts.poppins(
            fontSize: 35,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Color(0xFF1a237e),
      ),
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a237e),
              Color(0xFF283593),
              Color(0xFF303f9f),
              Color(0xFF3949ab),
            ],
          ),
        ),
        child: PortfolioHomePage(),
      ),
    );
  }
}
