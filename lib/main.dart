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
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      // TODO: Replace or append input based on the flags.
      // TODO: Handle "0" and ".".
    });
  }

  void chooseOperator(String nextOperator) {
    setState(() {
      // TODO: Apply an existing operation, or store the first operand.
      // TODO: Save nextOperator and wait for the next number.
    });
  }

  void applyPendingOperation() {
    // TODO: Read storedValue, operator, and double.tryParse(display).
    // TODO: Use a switch for +, -, *, and /.
    // TODO: Update the stored value and format the display.
  }

  void calculate() {
    setState(() {
      // TODO: Check that both operands are available.
      // TODO: Apply the operation and mark the result.
    });
  }

  void clear() {
    setState(() {
      // TODO: Reset every state field.
    });
  }

  void negate() {
    setState(() {
      // TODO: Negate current number
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
