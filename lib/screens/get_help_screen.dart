import 'package:flutter/material.dart';

class GetHelpScreen extends StatelessWidget {
  const GetHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Help'),
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
                color: const Color(0xFFE4F3F0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 36,
                    color: Color(0xFF438F84),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'You do not have to figure everything out on your own.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        color: Color(0xFF23413D),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Talk to someone you trust',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23413D),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'If you are worried about your symptoms, consider speaking with a parent, guardian, school nurse, doctor, or another trusted adult.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF405552),
              ),
            ),

            const SizedBox(height: 18),

            const _HelpCard(

              icon: Icons.school_outlined,
              title: 'School nurse',
              description:
                  'A school nurse can help you understand what to do next and can let you know when further care may be needed.',
            ),

            const _HelpCard(
              icon: Icons.family_restroom,
              title: 'Parent or guardian',
              description:
                  'Let a trusted adult know how you are feeling, especially if your symptoms continue or become worse.',
            ),

            const _HelpCard(
              icon: Icons.local_hospital_outlined,
              title: 'Healthcare professional',
              description:
                  'A doctor or other qualified healthcare professional can assess symptoms and provide appropriate medical advice.',
            ),

            const SizedBox(height: 10),

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
                'Sick-bae provides general health information. It cannot diagnose illnesses or replace professional medical care.',
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

class _HelpCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _HelpCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB38A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF6E3D2A),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF23413D),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: Color(0xFF405552),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}