import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const FrutiApp());
}

class FrutiApp extends StatelessWidget {
  const FrutiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FrutiApp Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 102, 9, 142),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}