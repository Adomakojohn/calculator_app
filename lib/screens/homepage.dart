// ignore_for_file: avoid_unnecessary_containers

import 'package:calculator_app/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAnswer = "";
  var ansPressed;
  
  final List<String> button = [
    'C','Del','%','/',
    '7','8','9', 'x',
    '4', '5', '6', '-',
    '1', '2','3','+',
     '0','.','ANS','=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 91, 82, 115),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 295,
                  width: 390,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.all(25),
                        alignment: Alignment.centerLeft,
                        child: Text(userQuestion , style:const  TextStyle(fontSize: 30),),
                      ),
                      Container(
                        padding: const EdgeInsets.all(25),
                        alignment: Alignment.bottomRight,
                        child: Text(userAnswer , style:const  TextStyle(fontSize: 30),),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromARGB(255, 91, 82, 115),
                  child: GridView.builder(
                    itemCount: button.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return CalButtons(
                          buttonTapped: () {
                            setState(
                              () {
                                userQuestion = '';
                                userAnswer='';
                              },
                            );
                          },
                          color: const  Color.fromARGB(255, 6, 12, 45),
                          textColor: Colors.blue,
                          buttonText: button[index],
                        );
                      }  else if (index == 1) {
                        return CalButtons(
                          buttonTapped: () {
                            setState(
                              () {
                                userQuestion= userQuestion.substring(0, userQuestion.length-1);
                              },
                            );
                          },
                          color: Colors.black,
                          textColor: Colors.blue,
                          buttonText: button[index],
                        );
                      }
                       else if (index == button.length-1) {
                        return CalButtons(
                          buttonTapped: () {
                            setState(
                              () {
                                equalPressed();
                              },
                            );
                          },
                          color: const Color.fromARGB(255, 119, 136, 238),
                          textColor: Colors.black,
                          buttonText: button[index],
                        );
                      } else {
                        return CalButtons(
                          buttonTapped: () {
                            setState(
                              () {
                                userQuestion += button[index];
                              },
                            );
                          },
                          color: isOperator(button[index])
                              ? const Color.fromARGB(255, 119, 136, 238)
                              : Colors.white,
                          textColor: isOperator(button[index])
                              ? Colors.black
                              : Colors.black,
                          buttonText: button[index],
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) { 
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
   void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion= finalQuestion.replaceAll("x", "*");

     Parser p = Parser();
     Expression exp = p.parse(finalQuestion);
     ContextModel cm = ContextModel();
     double eval = exp.evaluate(EvaluationType.REAL, cm);

     userAnswer=eval.toString();
   }
}
