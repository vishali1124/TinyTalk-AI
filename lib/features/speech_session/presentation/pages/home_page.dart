import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/speech_provider.dart';
import 'session_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SpeechProvider>();

    if (p.loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (p.error != null) return Scaffold(body: Center(child: Text(p.error!)));

    return Scaffold(
      appBar: AppBar(title: const Text("Speech Buddy")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Language: ${p.lang}"),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SessionPage()),
              ),
              child: const Text("Start Session"),
            ),
          ],
        ),
      ),
    );
  }
}
