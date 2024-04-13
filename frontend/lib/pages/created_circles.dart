import 'package:flutter/material.dart';
import '../widgets/circle_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreatedCircles extends StatefulWidget {
  @override
  CreatedCirclesState createState() => CreatedCirclesState();
}

class CreatedCirclesState extends State<CreatedCircles> {
  List<Map<String, dynamic>> circlesData = [];
  void getUserCircles() async {
    var url = 'https://new-fellow-project.vercel.app/groups/joined';

    final response = await http.get(Uri.parse('$url/user'));
    if (response.statusCode == 200) {
      if(mounted) {
        setState(() => circlesData = List<Map<String, dynamic>>.from(jsonDecode(response.body)));
      }
    } else {
      throw Exception('Failed to load circles');
    }}

  @override
  void initState() {
    super.initState();
    getUserCircles();

  }
  //User? get currentUser => _firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: circlesData.length,
        itemBuilder: (context, index) {
          return CircleCard(
              imageUrl: circlesData[index]['imageUrl'],
              activity: circlesData[index]['activity'],
              latitude: circlesData[index]['location']['latitude'],
              longitude: circlesData[index]['location']['longitude'],
              description: circlesData[index]['description']
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}