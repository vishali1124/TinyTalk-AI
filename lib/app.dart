// TinyTalk AI - app.dart (placeholder)

import 'package:flutter/material.dart';
import 'features/speech_session/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech Buddy',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
