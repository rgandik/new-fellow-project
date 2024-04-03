import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/pages/second_page.dart';


class First_Page extends StatelessWidget {
  // final AuthService instance;

  // List<String> items = [];
  First_Page({Key? key}) : super (key: key);
  final _type = "Name";
  final TextEditingController _controllerName = TextEditingController();
  
  // @override
  @override
  // _First_PageState createState() => _First_PageState();

  // Widget _entryField(
  //     String title,
  //     TextEditingController controller
  //     ) {
  //   return TextField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //         labelText: title),
  //   );
  // }


  Widget _submitButton(BuildContext context) {
    var url = 'http://localhost:4000/users';
    // var currentUser = instance.currentUser;
    // print(currentUser?.uid);

    return ElevatedButton(
      onPressed: () async
      {
        // var response = await http.post(
        //     Uri.parse(url),
        //     headers: <String, String>{"Content-Type": "application/json"},
        //     body: json.encode(<String, String>{
        //       "uid": currentUser!.uid,
        //       "name": "stuff"
        //     })
        // );
        // print(response.statusCode);
        print("sad");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Second_Page(name: _controllerName.text)));
      },
      child: Text("Next"),
    );
  }


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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text('First Page'),
          _entryField(_type, _controllerName),
          _submitButton(context)
        ]
      ),
    )
  );

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }
}

// class _First_PageState extends State<First_Page> {
//   @override
//   List<String> items = [];
//
//   void addItem(String item) {
//     setState(() {
//       items.add(item);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }