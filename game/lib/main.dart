import 'package:flutter/material.dart';
import 'jogo_da_velha.dart'; // Importa o jogo da velha

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JogoDaVelhaPage(), // Chama a página do jogo da velha
    );
  }
}