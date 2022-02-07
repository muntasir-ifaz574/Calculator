import 'package:calculator/widgets/bottom.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  List button = [
    "AC",
    "DLT",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  void expression() {
    Parser p = Parser();
    Expression exp = p.parse(userInput);
    ContextModel cm = ContextModel();
    var evalue = exp.evaluate(EvaluationType.REAL, cm);
    userInput = evalue.toString();
  }

  isOperator(String x) {
    if (x == "%" || x == "+" || x == "-" || x == "*" || x == "/" || x == "=") {
      return true;
    }
    return false;
  }

  var userInput = "";
  var userOutput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 85.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        userInput,
                        style: TextStyle(color: Colors.black, fontSize: 35),
                      ),
                    ),
                    Divider(
                      indent: 25,
                      endIndent: 25,
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userOutput,
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: 350,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: button.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return ButtonWidgets(
                        onPressed: () {
                          setState(() {
                            userInput = "";
                          });
                        },
                        buttonColor: Colors.red.shade200,
                        buttonText: button[index],
                        buttonTextColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return ButtonWidgets(
                        onPressed: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonColor: Colors.red.shade200,
                        buttonText: button[index],
                        buttonTextColor: Colors.white,
                      );
                    } else if (index == button.length - 1) {
                      return ButtonWidgets(
                        onPressed: () {
                          setState(() {
                            expression();
                          });
                        },
                        buttonColor: Colors.red.shade200,
                        buttonText: button[index],
                        buttonTextColor: Colors.white,
                      );
                    } else {
                      return ButtonWidgets(
                        onPressed: () {
                          setState(() {
                            userInput = userInput + button[index];
                          });
                        },
                        buttonColor: isOperator(button[index])
                            ? Colors.blue.shade200
                            : Colors.blue.shade900,
                        buttonText: button[index],
                        buttonTextColor: Colors.white,
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }
}
