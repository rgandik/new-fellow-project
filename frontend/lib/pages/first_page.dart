import 'package:flutter/material.dart';

class First_Page extends StatelessWidget {
  First_Page({Key? key}) : super (key: key);

  Widget _entryField(
      String title,
      TextEditingController controller
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: title),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('1/3'),
    ),
    body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('First Page'),
        ]
      ),
    )
  );
}