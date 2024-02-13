import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator_app/widget/cuttom_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = "";
  String result = "";

  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "1",
    "2",
    "3",
    "*",
    "4",
    "5",
    "6",
    "+",
    "7",
    "8",
    "9",
    "-",
    "C",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    userInput,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(buttonList[index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget CustomButton(String text) {
  return InkWell(
    onTap: () {
      _handleButtons(text);
    },
    child: Ink(
      decoration: BoxDecoration(
        color: _getbgColor(text),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0.5,
            offset: Offset(-3, -3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: _getColor(text),
            fontSize: text == "=" ? 36 : 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Color _getColor(String text) {
  if (text == "/" ||
      text == "*" ||
      text == "+" ||
      text == "-" ||
      text == "C" ||
      text == "(" ||
      text == ")") {
    return Color.fromARGB(255, 252, 100, 100);
  }
  return Colors.white;
}

Color _getbgColor(String text) {
  if (text == "AC") {
    return Color.fromARGB(255, 252, 100, 100);
  }
  if (text == "=") {
    return Color.fromARGB(255, 104, 204, 159);
  }
  return Colors.black;
}

void _handleButtons(String text) {
  if (text == "AC") {
    setState(() {
      userInput = "";
      result = "";
    });
  } else if (text == "C") {
    setState(() {
      userInput = userInput.substring(0, userInput.length - 1);
    });
  } else if (text == "=") {
    setState(() {
      result = _calculate();
      userInput = result;
    });
  } else {
    setState(() {
      userInput += text;
    });
  }
}

String _calculate() {
  try {
    var exp = Parser().parse(userInput);
    var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
    return evaluation.toString();
  } catch (e) {
    print(e);
    return "Error";
  }
}
