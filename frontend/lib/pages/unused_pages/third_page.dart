import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/pages/unused_pages/fourth_page.dart';



class Third_Page extends StatelessWidget {
  // final AuthService instance;

  // List<String> items = [];
  Third_Page({Key? key, required this.name, required this.college}) : super (key: key);
  final _type = "Company Role";
  final String name;
  final String college;
  final TextEditingController _controllerName = TextEditingController();

  // @override
  @override
  // _Third_PageState createState() => _Third_PageState();

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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Fourth_Page(name: name, college: college, companyRole: _controllerName.text)));
        print("sad");
      },
      child: Text("Next"),
    );
  }


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('3/3'),
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

