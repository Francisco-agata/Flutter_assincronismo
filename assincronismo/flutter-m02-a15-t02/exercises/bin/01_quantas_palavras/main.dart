import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuantasPalavras(),
    ),
  );
}

class QuantasPalavras extends StatefulWidget {
  const QuantasPalavras({Key? key}) : super(key: key);

  @override
  _QuantasPalavrasState createState() => _QuantasPalavrasState();
}

class _QuantasPalavrasState extends State<QuantasPalavras> {
  Color corBase = const Color(0xFF5A36DF);
  TextEditingController campoPalavra = TextEditingController(text: "");
  String cronometro = "Quantas Palavras?";
  String palavraSorteada = "";
  bool isGame = false;
  int acertos = 0;
  List<String> listaPalavras = [
    "facilisis",
    "vestibulum",
    "torquent",
    "volutpat",
    "bibendum",
    "tincidunt",
    "himenaeos",
    "porttitor",
    "inceptos",
    "pulvinar",
    "consectetur",
    "pellentesque",
    "adipiscing",
    "ultricies",
    "condimentum",
    "suscipit",
    "pharetra",
    "feugiat",
    "ultrices",
    "euismod",
    "blandit",
    "faucibus",
    "ullamcorper",
    "scelerisque",
    "dignissim",
    "consequat",
    "venenatis",
    "hendrerit",
    "lobortis",
    "fringilla",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: corBase,
        title: Text(
          cronometro,
          style: const TextStyle(fontSize: 28),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              palavraSorteada,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: corBase,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: campoPalavra,
              textAlign: TextAlign.center,
            ),

            MaterialButton(
              color: corBase,
              child: const Text(
                "Enviar",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                verificarPalavra();
              },
            ),

            const SizedBox(height: 25),

            MaterialButton(
              color: corBase,
              child: const Text(
                "Start Game",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                startGame();
              },
            ),

            MaterialButton(
              color: Colors.grey,
              child: const Text(
                "?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
              onPressed: () {
                mostrarMensagem("Clique em Start Game, digite a palavra mostrada e clique em Enviar");
              },
            ),
          ],
        ),
      ),
    );
  }

  void startGame() {
    // Se o game n�o foi iniciado
    if (!isGame) {
      // Reseta os valores e inicia uma nova partida
      palavraSorteada = sortearPalavra();
      isGame = true;
      acertos = 0;
      int tempo = 30;

      // Inicia o cron�metro
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          tempo--;

          if (tempo > 0) {
            cronometro = tempo > 9 ? "00:$tempo" : "00:0$tempo";
          
          } else {
            // Para o cron�metro
            timer.cancel();
            mostrarMensagem("Acertou $acertos palavra(s)");
            cronometro = "Quantas Palavras?";
            campoPalavra.text = "";
            palavraSorteada = "";
            isGame = false;
          }
        });
      });
    }
  }

  void verificarPalavra() {
    // Se o game foi iniciado
    if (isGame) {
      // Se o usu�rio digitar a palavra sorteada
      if (campoPalavra.text == palavraSorteada) {
        // Recebe 1 ponto
        acertos++;
      }
      // Limpa o campo de texto
      campoPalavra.text = "";

      // Sorteia a pr�xima palavra
      sortearPalavra();
    }
  }

  String sortearPalavra() {
    Random random = Random();
    int tamanhoLista = listaPalavras.length;
    int numeroSorteado = random.nextInt(tamanhoLista) + 1;
    String palavra = listaPalavras[numeroSorteado];

    // Se a palavra sorteada for igual a anterior, sorteia outra palavra
    while (palavra == palavraSorteada) {
      numeroSorteado = random.nextInt(tamanhoLista) + 1;
      palavra = listaPalavras[numeroSorteado];
    }

    // Guarda a palavra sorteada
    palavraSorteada = palavra;
    return palavraSorteada;
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
      }
    );
  }
}