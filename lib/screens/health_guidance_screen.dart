import 'package:flutter/material.dart';
import 'get_help_screen.dart';

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

    if (text.contains('fever') || text.contains('hot')) {
      suggestions.add(
        'If you have a fever or feel unusually hot, let a trusted adult know and keep track of how you are feeling.',
      );
    }

    if (text.contains('dizzy') || text.contains('dizziness')) {
      suggestions.add(
        'If you feel dizzy, sit or rest somewhere safe and tell a trusted adult, especially if the feeling continues or becomes worse.',
      );
    }

    if (text.contains('tired') ||
        text.contains('fatigue') ||
        text.contains('weak')) {
      suggestions.add(
        'If you are feeling unusually tired or weak, give yourself time to rest and tell a trusted adult if it continues or affects your normal activities.',
      );
    }

    if (text.contains('pain') ||
        text.contains('ache') ||
        text.contains('hurt')) {
      suggestions.add(
        'Because you mentioned discomfort or pain, note where it is, when it started, and whether it is changing. A trusted adult or healthcare professional can help you decide what to do next.',
      );
    }

    if (text.contains('breath') ||
        text.contains('breathing') ||
        text.contains('shortness of breath')) {
      suggestions.add(
        'If you are having trouble breathing, tell a trusted adult immediately and seek appropriate medical help rather than relying only on the app.',
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

    return suggestions.take(3).toList();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.health_and_safety,
                    size: 34,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Thanks for telling us. Here are some general suggestions based on what you described.',
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
              color: Colors.white,
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

            ...suggestions.asMap().entries.map(
              (entry) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {},
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
    entry.value,
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
            ),

            const SizedBox(height: 8),

            Card(
              color: const Color(0xFFE4F3F0),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GetHelpScreen(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        size: 30,
                        color: Color(0xFF438F84),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Need more help?',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF23413D),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Talk to a trusted adult, school nurse, or healthcare professional.',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Color(0xFF405552),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF438F84),
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