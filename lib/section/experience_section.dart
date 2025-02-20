import 'package:flutter/material.dart';
import 'package:web_portfolio/widget/experience_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerWidth = screenWidth > 1200
        ? 1200
        : (screenWidth > 800 ? screenWidth * 0.8 : screenWidth * 0.95);
    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            'Professional Experience',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          ExperienceCard(
            title: 'Flutter Developer - Maktabah Al-Bakri Sdn.Bhd',
            company: 'Nilai, Negeri Sembilan, Malaysia (Hybrid)',
            period: 'Oct 2024 - Present',
            achievements: [
              'Successfully developed and launched Al-Inarah on Play Store, a comprehensive Flutter-based application featuring an integrated prayer times system, article, e-commerce ebook platform, digital access to Al-Quran & Al-Bayan, and premium subscription services',
              'Implemented secure payment gateway integration and completed development within 3 months using Flutter, Github, GetX & Provider frameworks, and RestAPI architecture',
              'Led software development team as project manager, orchestrating strategic timelines, coordinating regular team meetings, and facilitating progress presentations to stakeholders',
            ],
          ),
          ExperienceCard(
            title: 'Flutter Developer - Coruja Studio',
            company: 'Hamburg, Germany (Remote)',
            period: 'Feb 2024 - Present',
            achievements: [
              'Led the development of the Customer App Rent Car, incorporating features such as live car tracking, remote locking, and rental management',
              'Implemented advanced features including live map tracking, completed in 3 months using Flutter, Gitlab, Riverpod, and gRPC Service',
              'Leading the creation of the slicing design BörnTee Loyalty App to facilitate point redemption for users using Flutter and modular project architecture',
              'Developing the BörnTee POS (Point of Sales) application for cashier sales, utilizing Riverpod for state management and localization features for English and Indonesian users',
            ],
          ),
          ExperienceCard(
            title: 'Flutter Developer - PT. Nata Connexindo',
            company: 'Yogyakarta (On-Site)',
            period: 'April 2023 - May 2024',
            achievements: [
              'Developed Smart Resident Apps for Android & iOS supporting multiple user access (householders, residents, company staff, owners) for apartment monitoring, bills viewing, helpdesk, and operational records',
              'Built applications using Flutter, Bitbucket & Github, Provider State Management, Rest API, Retrofit, Floor Database, QR, Firebase FCM Notification & Crashlytics, MVVM Architecture, and Flavor',
              'Created Lead Connection Apps for management internal sales, featuring chatting, lead visit monitoring, schedule reminders, presence tracking, and notifications',
              'Contributed to feature development and bug fixing on existing apps using Kotlin',
              'Performed maintenance of office laptops',
            ],
          ),
          ExperienceCard(
            title: 'Android Developer (Internship) - PT. Autoplastik Indonesia',
            company: 'Karawang (On-Site)',
            period: 'June 2022 - Jan 2023',
            achievements: [
              'Designed and implemented the Pokayoke Mobile Apps for internal management use, facilitating barcode scanning and kanban matching',
              'Developed the Planning Production Control Mobile Apps for internal management to monitor machines, track production metrics, and scan barcodes on parts',
              'Built applications using Android Kotlin, MVVM architecture, REST API, Scan Barcode, Socket Channel, Room Db, and Notifications',
              'Assisted with recording problems in running machines and participated in manager meetings using waterfall methodology',
            ],
          ),
          ExperienceCard(
            title: 'Assistant Lecturer (Part-Time) - Amikom University',
            company: 'Yogyakarta (On-Site)',
            period: 'Aug 2021 - Feb 2022',
            achievements: [
              'Served as teaching assistant for "Application Program Package" course for 2021 class, explaining Microsoft Word, Excel, and Access',
              'Assisted for 28 practicum meetings to more than 80 students in 1 semester',
              'Acted as teaching assistant for "Mobile Programming Project" course for 2019 class, teaching Android Java fundamentals',
              'Conducted 14 practicum meetings for more than 50 students in 1 semester',
              'Assisted lecturers in designing lessons and evaluating student performance',
            ],
          ),
        ],
      ),
    );
  }
}
