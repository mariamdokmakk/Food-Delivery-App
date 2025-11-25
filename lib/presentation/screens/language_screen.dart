import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // 'en' for English, 'ar' for Arabic
  String _currentLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suggested',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // English Option
            RadioListTile<String>(
              value: 'en',
              groupValue: _currentLanguage,
              onChanged: (String? value) {
                setState(() {
                  _currentLanguage = value!;
                });
              },
              title: const Text(
                'English (US)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              activeColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.zero,
            ),

            const Divider(),

            // Arabic Option
            RadioListTile<String>(
              value: 'ar',
              groupValue: _currentLanguage,
              onChanged: (String? value) {
                setState(() {
                  _currentLanguage = value!;
                });
              },
              title: const Text(
                'Arabic',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              activeColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}