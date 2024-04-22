import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
class myButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  const myButton({
    required this.text,
    required this.onPressed,
    this.width = 333,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20,  fontWeight: FontWeight.bold,),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Constants.myOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set border radius to 0
          ),
          padding: EdgeInsets.zero, // Remove padding
        ),
      ),
    );
  }
}
