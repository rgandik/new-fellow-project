import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/services/auth_service.dart';
// import 'package:frontend/pages/Fourth_Page.dart';


class Fourth_Page extends StatelessWidget {
  // final AuthService instance;

  // List<String> items = [];
  Fourth_Page({Key? key, required this.name, required this.college, required this.companyRole}) : super (key: key);
  // final _type = "Gender";
  final String name;
  final String college;
  final String companyRole;

  final TextEditingController _controllerName = TextEditingController();

  // @override
  @override
  // _Fourth_PageState createState() => _Fourth_PageState();

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
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => Fourth_Page(name: name)));
        print("sad");
      },
      child: Text("Next"),
    );
  }


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Complete!'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: CardExample(name: name, college: college, companyRole: companyRole),
      )
  );

}


class CardExample extends StatelessWidget {
   CardExample({super.key, required this.name, required this.college, required this.companyRole});

  final String name;
  final String college;
  final String companyRole;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        // clipBehavior is necessary because, without it, the InkWell's animation
        // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
        // This comes with a small performance cost, and you should not set [clipBehavior]
        // unless you need it.
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 300,
            height: 100,

            child: Center (
              child: Text('Name: $name\nCollege: ${college}\nCompany Role: ${companyRole}'),            ),
          ),
        ),
      ),
    );
  }
}


