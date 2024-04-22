import 'package:flutter/material.dart';

class userInputField extends StatefulWidget {
  final TextEditingController controller;
  final bool error;
  final String? errorMessage;
  final String? hintText;

  userInputField({
    required this.controller,
    this.error = false,
    this.errorMessage,
    this.hintText = 'Search',
  });

  @override
  _userInputFieldState createState() => _userInputFieldState();
}

class _userInputFieldState extends State<userInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            // fillColor: widget.error ? Colors.red.withOpacity(0.1) : Colors.white,
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3.0),
            ),
          ),
        ),
        if (widget.error && widget.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 16,
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    widget.errorMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

      ],
    );
  }
}
