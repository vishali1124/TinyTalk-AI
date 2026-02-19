import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/speech_provider.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SpeechProvider>();
    final current = p.current;

    return Scaffold(
      appBar: AppBar(title: const Text("Session")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (current == null) const Text("No prompts available"),
            if (current != null) ...[
              Text(current.text, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: p.speakCurrent,
                child: const Text("Listen"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  await p.submitDummyAttempt(score: 80);
                  p.nextPrompt();
                },
                child: const Text("Submit (Dummy) + Next"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
