import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/symptom_provider.dart';
import '../data/health_database.dart';
import 'symptom_details_screen.dart';
import 'health_guidance_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _filteredSymptoms = HealthDatabase.getAllSymptoms();
  }

  void _filterSymptoms(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSymptoms = HealthDatabase.getAllSymptoms();
      } else {
        _filteredSymptoms = HealthDatabase.getAllSymptoms()
            .where(
              (symptom) =>
                  symptom.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  void _getHealthGuidance() {
    final description = _descriptionController.text.trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please describe what you are experiencing first.'),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sick Bay',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: colors.surface,
                    child: Icon(
                      Icons.health_and_safety,
                      size: 30,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Sick Bay',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF23413D),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'A calm place to describe how you feel and explore general health guidance.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF35514D),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'How are you feeling?',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23413D),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Describe what you are experiencing in your own words.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF52615F),
              ),
            ),

            const SizedBox(height: 14),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText:
                            'For example: I have a headache and feel tired...',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: Icon(Icons.edit_note),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7FBFA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _getHealthGuidance,
                        icon: const Icon(Icons.health_and_safety),
                        label: const Text(
                          'Get General Guidance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Explore Symptoms',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF23413D),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB38A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.touch_app,
                    color: Color(0xFF6E3D2A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            const Text(
              'Tap a symptom to explore more information.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF52615F),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: _searchController,
              onChanged: _filterSymptoms,
              decoration: InputDecoration(
                hintText: 'Search symptoms...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            ..._filteredSymptoms.map((symptom) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    context.read<SymptomProvider>().searchSymptom(symptom);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SymptomDetailsScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: colors.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.medical_information_outlined,
                            color: colors.primary,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Text(
                            symptom.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF263D3A),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                          color: colors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
