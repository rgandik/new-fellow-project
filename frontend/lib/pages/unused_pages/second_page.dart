import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/pages/unused_pages/third_page.dart';


class Second_Page extends StatelessWidget {
  // final AuthService instance;

  // List<String> items = [];
  Second_Page({Key? key, required this.name}) : super (key: key);
  final _type = "College";
  final String name;
  final TextEditingController _controllerName = TextEditingController();

  // @override
  @override
  // _Second_PageState createState() => _Second_PageState();

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
        print(name);
        // print("sadasdad");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Third_Page(name: name, college: _controllerName.text)));

      },
      child: Text("Next"),
    );
  }


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('2/3'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text('Second Page'),
              _entryField(_type, _controllerName),
              _submitButton(context)
            ]
        ),
      )
  );

}

