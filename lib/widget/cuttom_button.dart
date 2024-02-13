import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String userInput = ""; // Define userInput variable
String result = "0"; // Define result variable

Widget CustomButton(String text) {
  return InkWell(
    onTap: () {
      setState(() {
        handleButtons(text);
      });
    },
    child: Ink(
      // Add padding as needed
      decoration: BoxDecoration(
        color: getbgColor(text),
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
            color: getColor(text),
            fontSize: 26, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

void setState(Null Function() param0) {}

Color getColor(String text) {
  if (text == "/" ||
      text == "*" ||
      text == "+" ||
      text == "-" ||
      text == "C" ||
      text == "(" ||
      text == ")") {
    return Color.fromARGB(255, 252, 100, 100);
  }

  // Add a default color in case the text doesn't match any condition
  return Colors.white;
}

Color getbgColor(String text) {
  // Change to 'Color' instead of 'void'
  if (text == "AC") {
    return Color.fromARGB(255, 252, 100, 100);
  }
  if (text == "=") {
    return Color.fromARGB(255, 104, 204, 159);
  }
  // Add a default color in case the text doesn't match any condition
  return Colors.black;
}

void handleButtons(String text) {
  // Add void return type
  if (text == "AC") {
    userInput = "";
    result = "0";
    return;
  }
  if (text == "C") {
    userInput = userInput.substring(0, userInput.length - 1);
    return;
  }
  if (text == "=") {
    result = calculate();
    userInput = result;

    if (result.endsWith(".0")) {
      result = result.replaceAll(".0", "");
    }
    if (result.endsWith(".0")) {
      result = result.replaceAll(".0", "");
    }
    return;
  }
  userInput = userInput + text;
}

String calculate() {
  try {
    var exp = Parser().parse(userInput);
    var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
    return evaluation.toString();
  } catch (e) {
    print(e);
    return "Error";
  }
}
