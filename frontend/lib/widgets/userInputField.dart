import 'package:flutter/material.dart';

class userInputField extends StatefulWidget {

  final TextEditingController controller;
  userInputField({required this.controller});

  @override
  _userInputFieldState createState() => _userInputFieldState();
}

class _userInputFieldState extends State<userInputField> {

  @override
  void initState() {
    super.initState();
    // controller = TextEditingController(text: 'search');
    // widget.controller = TextEditingController(text: 'search');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3.0),
          )
      ),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}