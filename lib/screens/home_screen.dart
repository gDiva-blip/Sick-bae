import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/symptom_provider.dart';
import '../data/health_database.dart';
import 'symptom_details_screen.dart';

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

    // For now, show the information the user entered.
    // We will build the symptom-processing system next.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Your symptoms'),
          content: Text(
            'You described:\n\n$description\n\n'
            'We will use this information to provide general health guidance.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sick Bay'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Sick Bay',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Tell us what is going on and get general health guidance.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // Main symptom description section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What\'s going on?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Describe what you are feeling in your own words.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: _descriptionController,
                      maxLines: 7,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText:
                            'For example: I have had a headache since yesterday and I feel tired...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignLabelWithHint: true,
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _getHealthGuidance,
                        icon: const Icon(Icons.health_and_safety),
                        label: const Text(
                          'Get Health Guidance',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
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
            ),

            const SizedBox(height: 32),

            // Optional symptom explorer
            const Text(
              'Explore Symptoms',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'You can also browse common symptoms.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _searchController,
              onChanged: _filterSymptoms,
              decoration: InputDecoration(
                hintText: 'Search symptoms...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            ..._filteredSymptoms.map((symptom) {
              return GestureDetector(
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
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          symptom.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
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