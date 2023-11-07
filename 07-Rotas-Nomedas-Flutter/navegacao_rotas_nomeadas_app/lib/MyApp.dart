import 'package:flutter/material.dart';
import 'package:navegacao_rotas_nomeadas_app/HomePage.dart';
import 'package:navegacao_rotas_nomeadas_app/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
          // Configurações de tema aqui
          ),
      // Configuração de rotas e outras configurações do aplicativo
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/contador': (context) => HomePage(title: 'Counter')
      }, // Defina a tela inicial do aplicativo aqui
    );
  }
}

// Outras classes e widgets podem ser definidos abaixo de MyApp
