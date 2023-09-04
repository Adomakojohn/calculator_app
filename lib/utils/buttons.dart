import 'package:flutter/material.dart';


class CalButtons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
 

  const  CalButtons({super.key, required this.color, required this.textColor,required this.buttonText , required this.buttonTapped });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect( borderRadius: BorderRadius.circular(18),
        child: GestureDetector( 
          onTap:buttonTapped,
          child: Container( 
            color: color,
            child: Center(child: Text(buttonText , style: TextStyle(color: textColor ,fontSize: 30 ),)),
          ),
        ),
      ),
    );
  }
}