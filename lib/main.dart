// TinyTalk AI - main.dart (placeholder)
/**void main() {
  print('TinyTalk AI scaffold');
}**/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/network/dio_client.dart';
import 'core/network/api_client.dart';
import 'services/tts/tts_service.dart';

import 'features/speech_session/data/datasources/speech_remote_ds.dart';
import 'features/speech_session/data/repositories/speech_repository_impl.dart';
import 'features/speech_session/presentation/providers/speech_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();
  final apiClient = ApiClient(dioClient.dio);
  final ttsService = TtsService();

  final speechRemote = SpeechRemoteDs(apiClient);
  final speechRepo = SpeechRepositoryImpl(speechRemote);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SpeechProvider(repo: speechRepo, tts: ttsService)..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
