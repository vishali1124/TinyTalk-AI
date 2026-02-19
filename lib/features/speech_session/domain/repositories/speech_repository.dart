import '../entities/prompt.dart';

abstract class SpeechRepository {
  Future<List<Prompt>> fetchPrompts({required String lang});
  Future<void> submitAttempt(Map<String, dynamic> payload);
}
