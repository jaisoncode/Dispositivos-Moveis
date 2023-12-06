import 'package:flutter/material.dart';
import 'package:todo_app/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade500),
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}
