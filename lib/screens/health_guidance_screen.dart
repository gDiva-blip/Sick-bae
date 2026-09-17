import 'package:flutter/material.dart';

class HealthGuidanceScreen extends StatelessWidget {
  final String description;

  const HealthGuidanceScreen({
    Key? key,
    required this.description,
  }) : super(key: key);

  List<String> _getSuggestions() {
    final text = description.toLowerCase();
    final suggestions = <String>[];

    if (text.contains('headache') ||
        text.contains('head pain') ||
        text.contains('migraine')) {
      suggestions.add(
        'For a headache, consider taking a quiet break, drinking some water if appropriate, and paying attention to whether it improves.',
      );
    }

    if (text.contains('stomach') ||
        text.contains('tummy') ||
        text.contains('nausea')) {
      suggestions.add(
        'For stomach discomfort or nausea, take things gently and keep track of when the symptoms happen and whether they change.',
      );
    }

    if (text.contains('cough') ||
        text.contains('cold') ||
        text.contains('sore throat')) {
      suggestions.add(
        'For cough or cold-like symptoms, rest and keep track of how you are feeling. Let a trusted adult know if the symptoms continue or get worse.',
      );
    }

    if (text.contains('tired') ||
        text.contains('fatigue') ||
        text.contains('weak')) {
      suggestions.add(
        'If you are feeling unusually tired or weak, give yourself time to rest and tell a trusted adult if it continues or affects your normal activities.',
      );
    }

    if (text.contains('pain')) {
      suggestions.add(
        'Because you mentioned pain, note where it is, when it started, and whether it is changing. A trusted adult or healthcare professional can help you decide what to do next.',
      );
    }

    if (suggestions.isEmpty) {
      suggestions.add(
        'Keep track of your symptoms, including when they started and whether they are getting better or worse.',
      );
      suggestions.add(
        'Consider talking to a parent, guardian, school nurse, doctor, or another trusted adult if you are concerned or the symptoms continue.',
      );
    }

    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final suggestions = _getSuggestions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Guidance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.health_and_safety,
                    size: 34,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Here are some general suggestions based on what you described.',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF23413D),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'What you described',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23413D),
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFF263D3A),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Suggestions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23413D),
              ),
            ),

            const SizedBox(height: 10),

            ...suggestions.map(
              (suggestion) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB38A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          size: 20,
                          color: Color(0xFF6E3D2A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          suggestion,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF263D3A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4EE),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFFB38A),
                ),
              ),
              child: const Text(
                'Important: Sick Bay provides general health information, not a diagnosis. If you feel seriously unwell, your symptoms are getting worse, or you are worried about them, tell a trusted adult and seek appropriate medical care.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF5A4035),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
