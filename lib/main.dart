import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorApp(title: 'Calculator App'),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key, required this.title});

  final String title;

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String display = "0";       // Current input or result
  String operator = "";      // Pending +, -, *, or /
  double? storedValue;       // First operand or running total
  bool waiting = false;      // Next digit starts the second operand
  bool hasResult = false;    // Next digit starts a new calculation
  void inputDigit(String digit) {
    setState(() {
      if (hasResult) {
        storedValue = null;
        operator = "";
      }

      if (waiting || hasResult || display == "0") {
        display = digit;
      } else {
        display += digit;
      }

      waiting = false;
      hasResult = false;
    });
  }

  void chooseOperator(String nextOperator) {
    setState(() {
      if (operator.isNotEmpty && !waiting) {
        applyPendingOperation();
      } else {
        storedValue = double.tryParse(display);
      }

      operator = nextOperator;
      waiting = true;
      hasResult = false;
    });
  }

  void applyPendingOperation() {
    final first = storedValue;
    final currentVal = double.tryParse(display);

    if (first == null || currentVal == null) {
      return;
    }
    double result;
    switch (operator) {
      case "+":
        result = first + currentVal;
        break;
      case "-":
        result = first - currentVal;
        break;
      case "*":
        result = first * currentVal;
        break;
      case "/":
        result = first / currentVal;
        break;
      case "%":
        result = first % currentVal;
        break;
      default:
        return;
    }
    storedValue = result;
    display = result.toString();
  }

  void calculate() {
    setState(() {
      if (operator.isEmpty || waiting) return;

      applyPendingOperation();
      operator = "";
      waiting = false;
      hasResult = true;
    });
  }

  void clear() {
    setState(() {
      // Reset every state field.
        display = "0";
        operator = "";
        storedValue = null;
        waiting = true;
        hasResult = false;
    });
  }

  void negate() {
    setState(() {
      final val = storedValue;
      if(val == null){
        return;
      }
      storedValue = -val;
      display = storedValue.toString();
    });
  }

  Widget calculatorButton(
    String label,
    VoidCallback onPressed, {
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 64,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(label, style: const TextStyle(fontSize: 24)),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    display,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                calculatorButton("AC", clear),
                calculatorButton("+/-", negate),
                calculatorButton("%", () => chooseOperator("%")),
                calculatorButton("÷", () => chooseOperator("/")),
              ],
            ),
            Row(
              children: [
                calculatorButton("7", () => inputDigit("7")),
                calculatorButton("8", () => inputDigit("8")),
                calculatorButton("9", () => inputDigit("9")),
                calculatorButton("×", () => chooseOperator("*")),
              ],
            ),
            Row(
              children: [
                calculatorButton("4", () => inputDigit("4")),
                calculatorButton("5", () => inputDigit("5")),
                calculatorButton("6", () => inputDigit("6")),
                calculatorButton("−", () => chooseOperator("-")),
              ],
            ),
            Row(
              children: [
                calculatorButton("1", () => inputDigit("1")),
                calculatorButton("2", () => inputDigit("2")),
                calculatorButton("3", () => inputDigit("3")),
                calculatorButton("+", () => chooseOperator("+")),
              ],
            ),
            Row(
              children: [
                calculatorButton("0", () => inputDigit("0"), flex: 3),
                calculatorButton("=", calculate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
