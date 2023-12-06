import 'package:flutter/material.dart';
import 'package:todo_app/app_controller.dart';
import 'package:todo_app/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance, 
      builder: (context, child) {
        return MaterialApp(
            title: 'Todo App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade500)
                .copyWith(brightness: AppController.instance.isDarkTheme ? Brightness.dark : Brightness.light),
              useMaterial3: false,
            ),
            home: const HomePage(),
          );
      },);
  }
}
