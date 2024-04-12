import 'package:flutter/material.dart';
import 'package:frontend/pages/explore_screen.dart';

// The main application entry point and MyApp class are omitted if this is part of a larger app

class ActivityCardPage extends StatefulWidget {
  // Assuming you might want to pass some data to this page
  final String activityImageUrl;
  final String activity;
  final String distance;
  final String description;

  ActivityCardPage({
    Key? key,
    required this.activityImageUrl,
    required this.activity,
    required this.distance,
    required this.description,
  }) : super(key: key);

  @override
  _ActivityCardPageState createState() => _ActivityCardPageState();
}

class _ActivityCardPageState extends State<ActivityCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
      Expanded(
      child: Image.network(
      widget.activityImageUrl,
        fit: BoxFit.cover,
      ),
    ),
    Container(
    padding: EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    widget.activity,
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
      SizedBox(height: 8),
      Text(
        '${widget.distance} Distance',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      SizedBox(height: 16),
      Text(
        widget.description,
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(height: 24),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              child: Text('Join Circle'),
              onPressed: () {
                // Handle join circle action
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              child: Text('Go Back'),
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    ],
    ),
    ),
        ],
      ),
    );
  }
}