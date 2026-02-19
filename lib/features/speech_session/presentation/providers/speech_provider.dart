import 'package:flutter/foundation.dart';
import '../../domain/entities/prompt.dart';
import '../../domain/repositories/speech_repository.dart';
import '../../../../services/tts/tts_service.dart';

class SpeechProvider extends ChangeNotifier {
  final SpeechRepository repo;
  final TtsService tts;

  SpeechProvider({required this.repo, required this.tts});

  bool loading = false;
  String? error;
  List<Prompt> prompts = [];
  Prompt? current;
  String lang = "en"; // "en" or "ta"

  Future<void> init() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await tts.init();
      await tts.setLanguage(lang == "ta" ? "ta-IN" : "en-US");
      prompts = await repo.fetchPrompts(lang: lang);
      current = prompts.isNotEmpty ? prompts.first : null;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> speakCurrent() async {
    if (current == null) return;
    await tts.speak(current!.text);
  }

  void nextPrompt() {
    if (prompts.isEmpty) return;
    final idx = prompts.indexOf(current ?? prompts.first);
    current = prompts[(idx + 1) % prompts.length];
    notifyListeners();
  }

  Future<void> changeLanguage(String newLang) async {
    lang = newLang;
    await tts.setLanguage(lang == "ta" ? "ta-IN" : "en-US");
    notifyListeners();
  }

  Future<void> submitDummyAttempt({required int score}) async {
    if (current == null) return;
    final payload = {
      "promptId": current!.id,
      "score": score,
      "lang": lang,
      "timestamp": DateTime.now().toIso8601String(),
    };
    await repo.submitAttempt(payload);
  }
}
