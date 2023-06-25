import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _equation = "";
  double? num1;
  double? num2;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _equation = "";
      num1 = null;
      num2 = null;
      operand = "";
    } else if (buttonText == "DEL") {
      _output = _output.substring(0, _output.length - 1);
      if (_output.isEmpty) {
        _output = "0";
      }
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/") {
      num1 = double.parse(_output);
      operand = buttonText;
      _equation += "$num1 $operand ";
      _output = "0";
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += ".";
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      _equation += "$num2";

      switch (operand) {
        case "+":
          _output = (num1! + num2!).toStringAsFixed(2);
          break;
        case "-":
          _output = (num1! - num2!).toStringAsFixed(2);
          break;
        case "x":
          _output = (num1! * num2!).toStringAsFixed(2);
          break;
        case "/":
          if (num2 == 0) {
            _output = "ERROR";
          } else {
            _output = (num1! / num2!).toStringAsFixed(2);
          }
          break;
      }

      num1 = null;
      num2 = null;
      operand = "";
      _equation = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }

    setState(() {
      _output = _output;
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return ElevatedButton(
      onPressed: () => buttonPressed(buttonText),
      // ignore: sort_child_properties_last
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 25.0,
          color: textColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        primary: buttonColor,
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            // ignore: sort_child_properties_last
            child: Text(
              _equation,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
            ),
            alignment: const Alignment(1.0, 1.0),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            // ignore: sort_child_properties_last
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            alignment: const Alignment(1.0, 1.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton("C", Colors.red[400]!, Colors.white),
              buildButton("DEL", Colors.grey[700]!, Colors.white),
              buildButton("%", Colors.grey[700]!, Colors.white),
              buildButton("/", Colors.grey[700]!, Colors.white),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton("9", Colors.grey[300]!, Colors.black),
              buildButton("8", Colors.grey[300]!, Colors.black),
              buildButton("7", Colors.grey[300]!, Colors.black),
              buildButton("x", Colors.grey[700]!, Colors.white),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton("6", Colors.grey[300]!, Colors.black),
              buildButton("5", Colors.grey[300]!, Colors.black),
              buildButton("4", Colors.grey[300]!, Colors.black),
              buildButton("-", Colors.grey[700]!, Colors.white),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton("3", Colors.grey[300]!, Colors.black),
              buildButton("2", Colors.grey[300]!, Colors.black),
              buildButton("1", Colors.grey[300]!, Colors.black),
              buildButton("+", Colors.grey[700]!, Colors.white),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton("0", Colors.grey[300]!, Colors.black),
              buildButton(".", Colors.grey[300]!, Colors.black),
              buildButton("ANS", Colors.grey[700]!, Colors.white),
              buildButton("=", Colors.teal[300]!, Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
