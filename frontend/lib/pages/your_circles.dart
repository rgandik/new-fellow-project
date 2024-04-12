import 'package:flutter/material.dart';
import '../widgets/circleCard.dart';
import 'activity_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class YourCirclesPage extends StatefulWidget {
  @override
  _YourCirclesPageState createState() => _YourCirclesPageState();
}

class _YourCirclesPageState extends State<YourCirclesPage> {
  List<Map<String, dynamic>> circlesData = [];
  void getUserCircles() async {
    var url = 'https://new-fellow-project.vercel.app/groups/joined';

    final response = await http.get(Uri.parse('$url/test'));
    if (response.statusCode == 200) {
      if(mounted) {
        setState(() => circlesData = List<Map<String, dynamic>>.from(jsonDecode(response.body)));
        print(circlesData);
      }
    } else {
      throw Exception('Failed to load circles');
    }}
  // Example list of circle data; replace with your own data source
  /*List<Map<String, dynamic>> circlesData = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'activity': 'Activity One',
      'distance': '10 miles',
      'description': 'Description 1'
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'activity': 'Activity Two',
      'distance': '20 miles',
      'description': 'Description 2'
    },
    // Add more items...
  ];*/

  @override
  void initState() {
    super.initState();
    getUserCircles();

  }
  //User? get currentUser => _firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Circles'),
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
      ),
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
      ),
    );
  }
}