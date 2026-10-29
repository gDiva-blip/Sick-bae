
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/health_database.dart';
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
  final TextEditingController _searchController =
      TextEditingController();

  List<String> _filteredSymptoms = [];

  static const Color _background = Color(0xFFF6FBF8);
  static const Color _darkGreen = Color(0xFF23413D);
  static const Color _mutedGreen = Color(0xFF526A65);
  static const Color _peach = Color(0xFFFFE1D5);
  static const Color _peachDark = Color(0xFF8A3F2B);

  @override
  void initState() {
    super.initState();
    _filteredSymptoms = HealthDatabase.getAllSymptoms();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterSymptoms(String query) {
    final searchTerm = query.trim().toLowerCase();

    setState(() {
      _filteredSymptoms = HealthDatabase.getAllSymptoms()
          .where(
            (symptom) => symptom.toLowerCase().contains(searchTerm),
          )
          .toList();
    });
  }

  void _getHealthGuidance([String? selectedSymptom]) {
    final description =
        (selectedSymptom ?? _descriptionController.text).trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please describe how you are feeling first.',
          ),
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

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open this link. Please try again.'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open this link. Please try again.'),
        ),
      );
    }
  }

  Widget _buildBandagedHeart() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _peach,
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.favorite_rounded,
              color: _peachDark,
              size: 27,
            ),
            Positioned(
              top: 8,
              right: 7,
              child: Transform.rotate(
                angle: -0.55,
                child: Container(
                  width: 17,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: _peachDark,
                      width: 0.8,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 6,
                      color: _peachDark,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatorFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 22, 8, 8),
      child: Column(
        children: [
          const Divider(color: Color(0xFFDCEAE5)),
          const SizedBox(height: 18),
          const Icon(
            Icons.favorite_rounded,
            color: Color(0xFF438F84),
            size: 25,
          ),
          const SizedBox(height: 8),
          const Text(
            'Made by Godiva Amoah',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _darkGreen,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Your health, with a little care.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _mutedGreen,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _openLink(
                  'https://github.com/gDiva-blip/Sick-bae',
                ),
                icon: const Icon(Icons.code_rounded, size: 18),
                label: const Text('GitHub'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _darkGreen,
                  side: const BorderSide(color: Color(0xFFB8CEC6)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _openLink(
                  'https://www.linkedin.com/in/godiva-amoah-869a84434/',
                ),
                icon: const Icon(Icons.work_outline_rounded, size: 18),
                label: const Text('LinkedIn'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _darkGreen,
                  side: const BorderSide(color: Color(0xFFB8CEC6)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _openLink(
                  'mailto:g90579106@gmail.com',
                ),
                icon: const Icon(Icons.email_outlined, size: 18),
                label: const Text('Email'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _darkGreen,
                  side: const BorderSide(color: Color(0xFFB8CEC6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Take care of yourself. 💚',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _mutedGreen,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        foregroundColor: _darkGreen,
        elevation: 0,
        title: Row(
          children: [
            _buildBandagedHeart(),
            const SizedBox(width: 12),
            const Column(
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
            // Important medical disclaimer.
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
                    'SICK BAE DOES NOT DIAGNOSE ILLNESSES OR '
                    'REPLACE A DOCTOR OR OTHER QUALIFIED '
                    'HEALTHCARE PROFESSIONAL.',
                    style: TextStyle(
                      color: Color(0xFF702521),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The information in this app is general '
                    'guidance only. If you feel seriously unwell, '
                    'your symptoms are getting worse, or you are '
                    'worried, tell a trusted adult and seek '
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
                          'A calm place to describe how you feel, '
                          'explore common symptoms, and find out '
                          'where to get support.',
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
              'Describe what you are experiencing in your '
              'own words.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: _mutedGreen,
              ),
            ),
            const SizedBox(height: 14),

            // Free-text symptom description.
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(
                  color: Color(0xFFDCEAE5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'For example: I have a headache...',
                        hintMaxLines: 3,
                        filled: true,
                        fillColor: _background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(14),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: _getHealthGuidance,
                      icon: const Icon(Icons.favorite_outline),
                      label: const Text('Get guidance'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _darkGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Search common symptoms.
            const Text(
              'Explore common symptoms',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: _darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Search for a symptom to explore general guidance.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: _mutedGreen,
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: _searchController,
              onChanged: _filterSymptoms,
              decoration: InputDecoration(
                hintText: 'Search symptoms...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: _mutedGreen,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFDCEAE5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFDCEAE5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            if (_filteredSymptoms.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'No matching symptoms found. Try another search.',
                  style: TextStyle(color: _mutedGreen),
                ),
              )
            else
              ..._filteredSymptoms.map(
                (symptom) => Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(
                      color: Color(0xFFDCEAE5),
                    ),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE4F3F0),
                      child: Icon(
                        Icons.health_and_safety_outlined,
                        color: _darkGreen,
                      ),
                    ),
                    title: Text(
                      symptom,
                      style: const TextStyle(
                        color: _darkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: _mutedGreen,
                    ),
                    onTap: () => _getHealthGuidance(symptom),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Get further support.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _peach,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Need more support?',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: _darkGreen,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'You can find out where to get help from a '
                    'trusted adult or healthcare professional.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: _darkGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _openGetHelp,
                      icon: const Icon(Icons.support_agent_rounded),
                      label: const Text('Get help'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _peachDark,
                        side: const BorderSide(
                          color: _peachDark,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Creator footer.
            _buildCreatorFooter(),
          ],
        ),
      ),
    );
  }
}
