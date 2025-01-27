import 'package:flutter/material.dart';

class JogoDaVelhaPage extends StatefulWidget {
  const JogoDaVelhaPage({super.key});

  @override
  _JogoDaVelhaPageState createState() => _JogoDaVelhaPageState();
}

class _JogoDaVelhaPageState extends State<JogoDaVelhaPage> {
  List<String> _board = List.filled(9, ""); // Tabuleiro inicial
  String _currentPlayer = "X"; // Jogador inicial
  bool _gameActive = true; // Indica se o jogo está ativo
  String _status = "Jogador X começa!"; // Status do jogo

  // Reinicia o jogo
  void _resetGame() {
    setState(() {
      _board = List.filled(9, "");
      _currentPlayer = "X";
      _gameActive = true;
      _status = "Jogador X começa!";
    });
  }

  // Verifica se há um vencedor
  String? _checkWinner() {
    const winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombos) {
      final a = combo[0];
      final b = combo[1];
      final c = combo[2];

      if (_board[a] != "" && _board[a] == _board[b] && _board[a] == _board[c]) {
        return _board[a];
      }
    }

    return _board.contains("") ? null : "Empate";
  }

  // Atualiza o status do jogo após cada jogada
  void _handleTap(int index) {
    if (!_gameActive || _board[index] != "") return;

    setState(() {
      _board[index] = _currentPlayer;
      final winner = _checkWinner();

      if (winner != null) {
        _gameActive = false;
        _status = winner == "Empate"
            ? "Empate!"
            : "Jogador $_currentPlayer venceu!";
      } else {
        _currentPlayer = _currentPlayer == "X" ? "O" : "X";
        _status = "Vez do jogador $_currentPlayer";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jogo da Velha"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _status,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          _buildGameBoard(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text("Reiniciar Jogo"),
          ),
        ],
      ),
    );
  }

  // Cria o tabuleiro
  Widget _buildGameBoard() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _handleTap(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  _board[index],
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}