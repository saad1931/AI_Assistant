import 'package:flutter/material.dart';
import 'package:personalassistant/home_ai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Assistant',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
      home: const HomeAI(),
    );
  }
}