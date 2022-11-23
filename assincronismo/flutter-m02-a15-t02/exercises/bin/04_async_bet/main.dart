import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AsyncBet(),
    ),
  );
}

class AsyncBet extends StatefulWidget {
  const AsyncBet({Key? key}) : super(key: key);

  @override
  _AsyncBetState createState() => _AsyncBetState();
}

class _AsyncBetState extends State<AsyncBet> {
  // Declara��o dos atributos (vari�veis)
  Color cor1 = const Color(0xFF126E51);
  Color cor2 = const Color(0xFFFFDC17);
  Color cor3 = Colors.white;
  Color cor4 = Colors.redAccent;
  Color cor5 = Colors.deepPurpleAccent;
  Color cor6 = Colors.blue;
  Color cor7 = Colors.blueGrey.shade100;
  double porcentagem1 = 100.0;
  double porcentagem2 = 100.0;
  double porcentagem3 = 100.0;
  double larguraPista = 35;
  bool isGame = false;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cor1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Async",
                  style: TextStyle(
                    fontSize: 28,
                    color: cor3,
                  ),
                ),
                Text(
                  "Bet",
                  style: TextStyle(
                    fontSize: 28,
                    color: cor2,
                  ),
                ),
              ],
            ),
            MaterialButton(
              color: cor3,
              child: Text(
                "start",
                style: TextStyle(
                  fontSize: 20,
                  color: cor1,
                ),
              ),
              onPressed: () {
                startGame();
              },
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: LinearProgressIndicator(
                value: porcentagem1 / 100,
                minHeight: larguraPista,
                color: cor4,
                backgroundColor: cor7,
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: LinearProgressIndicator(
                value: porcentagem2 / 100,
                minHeight: larguraPista,
                color: cor5,
                backgroundColor: cor7,
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: LinearProgressIndicator(
                value: porcentagem3 / 100,
                minHeight: larguraPista,
                color: cor6,
                backgroundColor: cor7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startGame() {
    // Se a partida n�o come�ou
    if (!isGame) {
      isGame = true;
      resetarValores();

      // Pista 1
      Timer.periodic(const Duration(seconds: 1), (timer) {
        porcentagem1 -= random.nextDouble() * 10;

        if (porcentagem1 >= 0 && isGame) {
          setState(() {
            porcentagem1;
          });
        } else {
          timer.cancel();
          // Se zerou a pista e a partida est� ativa
          if (isGame) {
            mostrarMensagem("Vermelho venceu!");
            isGame = false;
          }
        }
      });

      // Pista 2
      Timer.periodic(const Duration(seconds: 1), (timer) {
        porcentagem2 -= random.nextDouble() * 10;

        if (porcentagem2 >= 0 && isGame) {
          setState(() {
            porcentagem2;
          });
        } else {
          timer.cancel();
          // Se zerou a pista e a partida est� ativa
          if (isGame) {
            mostrarMensagem("Roxo venceu!");
            isGame = false;
          }
        }
      });

      // Pista 3
      Timer.periodic(const Duration(seconds: 1), (timer) {
        porcentagem3 -= random.nextDouble() * 10;

        if (porcentagem3 >= 0 && isGame) {
          setState(() {
            porcentagem3;
          });
        } else {
          timer.cancel();
          // Se zerou a pista e a partida est� ativa
          if (isGame) {
            mostrarMensagem("Azul venceu!");
            isGame = false;
          }
        }
      });
    }
  }

  void mostrarMensagem(String mensagem) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              mensagem,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          );
        });
  }

  void resetarValores() {
    setState(() {
      porcentagem1 = 100.0;
      porcentagem2 = 100.0;
      porcentagem3 = 100.0;
    });
  }
}