import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TryCatch(),
    ),
  );
}

class TryCatch extends StatefulWidget {
  const TryCatch({Key? key}) : super(key: key);

  @override
  _TryCatchState createState() => _TryCatchState();
}

class _TryCatchState extends State<TryCatch> {
  // Declara��o dos atributos (vari�veis)
  TextEditingController campoValor1 = TextEditingController(text: "");
  TextEditingController campoValor2 = TextEditingController(text: "");
  FocusNode campo1 = FocusNode();
  FocusNode campo2 = FocusNode();
  double valor1 = 0;
  double valor2 = 0;
  double resultado = 0;
  Color corBase = Colors.red.shade600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: corBase,
        title: const Text(
          "Try Catch",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        color: Colors.amber.shade50,
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              controller: campoValor1,
              focusNode: campo1,
              autofocus: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: corBase,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: campoValor2,
              focusNode: campo2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: corBase,
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: corBase,
              onPressed: calcular,
              child: const Text(
                "Calcular",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calcular() {
    // Tenta converter para valores num�ricos
    try {
      valor1 = double.parse(campoValor1.text);
    } catch (e) {
      mostrarMensagem("Informe apenas n�meros");
      FocusScope.of(context).requestFocus(campo1);
      return;
    }

    try {
      valor2 = double.parse(campoValor2.text);
    } catch (e) {
      mostrarMensagem("Informe apenas n�meros");
      FocusScope.of(context).requestFocus(campo2);
      return;
    }

    resultado = valor1 + valor2;
    mostrarMensagem("Resultado: ${resultado.toStringAsFixed(2)}");

    resetarValores();
  }

  void mostrarMensagem(String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(mensagem),
        );
      },
    );
  }

  void resetarValores() {
    valor1 = 0;
    valor2 = 0;
    campoValor1.text = "";
    campoValor2.text = "";
    FocusScope.of(context).requestFocus(campo1);
  }
}