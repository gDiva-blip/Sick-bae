import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/symptom_provider.dart';
import '../data/health_database.dart';
import 'symptom_details_screen.dart';
import 'health_guidance_screen.dart';
import 'get_help_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _descriptionController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<String> _filteredSymptoms = [];

  static const Color _background = Color(0xFFF6FBF8);
  static const Color _darkGreen = Color(0xFF23413D);
  static const Color _mutedGreen = Color(0xFF526A65);
  static const Color _peach = Color(0xFFFFE1D5);
  static const Color _peachDark = Color(0xFF8A3F2B);
  static const Color _softGreen = Color(0xFFE4F3F0);

  @override
  void initState() {
    super.initState();
    _filteredSymptoms = HealthDatabase.getAllSymptoms();
  }

  void _filterSymptoms(String query) {
    setState(() {
      _filteredSymptoms = HealthDatabase.getAllSymptoms()
          .where(
            (symptom) =>
                symptom.toLowerCase().contains(query.trim().toLowerCase()),
          )
          .toList();
    });
  }

  void _getHealthGuidance() {
    final description = _descriptionController.text.trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please describe how you are feeling first.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HealthGuidanceScreen(
          description: description,
        ),
      ),
    );
  }

  void _openGetHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GetHelpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        foregroundColor: _darkGreen,
        elevation: 0,
        title: const Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: _peach,
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  Icons.favorite_rounded,
                  color: _peachDark,
                  size: 26,
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sick Bae',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: _darkGreen,
                  ),
                ),
                Text(
                  'Your health, with a little care',
                  style: TextStyle(
                    fontSize: 12,
                    color: _mutedGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMPORTANT MEDICAL DISCLAIMER — deliberately placed first.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8E4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFB83A32),
                  width: 2,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: Color(0xFF9F2924),
                        size: 29,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'IMPORTANT MEDICAL DISCLAIMER',
                          style: TextStyle(
                            color: Color(0xFF8D211D),
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'SICK BAE DOES NOT DIAGNOSE ILLNESSES OR REPLACE A '
                    'DOCTOR OR OTHER QUALIFIED HEALTHCARE PROFESSIONAL.',
                    style: TextStyle(
                      color: Color(0xFF702521),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The information in this app is general guidance only. '
                    'If you feel seriously unwell, your symptoms are getting '
                    'worse, or you are worried, tell a trusted adult and seek '
                    'appropriate medical care.',
                    style: TextStyle(
                      color: Color(0xFF702521),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Welcome section.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE4F3F0),
                    Color(0xFFF0F8F5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.health_and_safety_rounded,
                      size: 30,
                      color: Color(0xFF438F84),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Sick Bae',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _darkGreen,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'A calm place to describe how you feel, explore '
                          'common symptoms, and find out where to get support.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: _darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            const Text(
              'How are you feeling?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Describe what you are experiencing in your own words.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: _mutedGreen,
              ),
            ),
            const SizedBox(height: 14),

            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Color(0xFFDCEAE5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText:
                            'For example:
