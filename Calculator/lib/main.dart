import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 4,
          centerTitle: true,
          backgroundColor: Color.fromARGB(213, 122, 182, 66),
          title: Text(
            'Calculator',
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(183, 63, 47, 206),
                Color.fromARGB(183, 65, 160, 177),
              ],
            ),
          ),
          child: Center(child: CalculatorApp()),
        ),
      ),
    ),
  );
}

class CalculatorApp extends StatefulWidget {
  @override
  State<CalculatorApp> createState() {
    return Calculatorstate();
  }
}

class Calculatorstate extends State<CalculatorApp> {
  String screenText = "";
  onButtonClick(String label) {
    setState(() {
      if (label == 'CLR') {
        screenText = "";
      } else if (label == 'ANS') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(screenText);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          screenText = eval.toString();
        } catch (e) {
          screenText = "Error";
        }
      } else {
        screenText += label;
      }
    });
  }

  Widget buildButton(String label, bool isDigit) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shadowColor: Color.fromARGB(0, 0, 0, 0),
            backgroundColor:
                isDigit
                    ? Color.fromARGB(183, 123, 170, 79)
                    : Color.fromARGB(255, 228, 182, 32),
          ),
          onPressed: () => {onButtonClick(label)},
          child: Text(
            label,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            height: 100,
            color: Color.fromARGB(224, 89, 89, 91),
            child: Text(
              screenText,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ),
        Row(
          children: [
            buildButton('7', true),
            buildButton('8', true),
            buildButton('9', true),
            buildButton('+', false),
          ],
        ),
        Row(
          children: [
            buildButton('4', true),
            buildButton('5', true),
            buildButton('6', true),
            buildButton('-', false),
          ],
        ),
        Row(
          children: [
            buildButton('1', true),
            buildButton('2', true),
            buildButton('3', true),
            buildButton('*', false),
          ],
        ),
        Row(
          children: [
            buildButton('0', true),
            buildButton('.', false),
            buildButton('/', false),
            buildButton('%', false),
          ],
        ),
        Row(children: [buildButton('ANS', false), buildButton('CLR', false)]),
      ],
    );
  }
}
