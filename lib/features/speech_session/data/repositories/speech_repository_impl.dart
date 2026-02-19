import '../../domain/entities/prompt.dart';
import '../../domain/repositories/speech_repository.dart';
import '../datasources/speech_remote_ds.dart';

class SpeechRepositoryImpl implements SpeechRepository {
  final SpeechRemoteDs remote;
  SpeechRepositoryImpl(this.remote);

  @override
  Future<List<Prompt>> fetchPrompts({required String lang}) async {
    final models = await remote.fetchPrompts(lang: lang);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> submitAttempt(Map<String, dynamic> payload) => remote.submitAttempt(payload);
}
