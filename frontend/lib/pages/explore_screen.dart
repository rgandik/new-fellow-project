import 'package:flutter/material.dart';
import 'package:frontend/pages/activity_card.dart';
import '../constants.dart';
import 'create_circle.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}
class _ExploreScreenState extends State<ExploreScreen> {
  // Example list of circle data; replace with your own data source
  List<Map<String, dynamic>> circlesData = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'activityName': 'Activity One',
      'distance': '10 miles',
      'description': 'Description 1'
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'activityName': 'Activity Two',
      'distance': '20 miles',
      'description': 'Description 2'
    },
    // Add more items...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45.0,
          )
        ),
        elevation: 0,
        centerTitle: false,
        // Remove the shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
              children: <Widget>[
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search ...',
                      hintStyle: TextStyle(
                        fontSize: 20.0
                      ),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0
                        ),
                      ),
                      suffixIcon: Icon(Icons.tune),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateCircleScreen())
                  );
                },
                backgroundColor: Constants.myOrange,
                foregroundColor: Constants.myWhite,
                shape: CircleBorder(),
                mini: true,
                child: const Icon(Icons.add)
              ),
            ]
          ),
        ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: circlesData.length,
            itemBuilder: (context, index) {
              return CircleCard(
                imageUrl: circlesData[index]['imageUrl'],
                activityName: circlesData[index]['activityName'],
                distance: circlesData[index]['distance'],
                description: circlesData[index]['description']
              );
            },
          )
      ],
      )
      )
    );
  }
}

class CircleCard extends StatefulWidget {
  // final String imageUrl;
  final String activityName;
  final String distance;
  final String description;
  final String imageUrl;

  CircleCard({
    // required this.imageUrl,
    required this.activityName,
    required this.distance,
    required this.description,
    required this.imageUrl
  });

  @override
  _CircleCardState createState() => _CircleCardState();
}

class _CircleCardState extends State<CircleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Image.network(
              // widget.imageUrl,
              widget.imageUrl,
              height: 150.0,
              width: 300.0,
              fit: BoxFit.cover,
            ),
            onTap: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ActivityCardPage(
                          activityImageUrl: widget.imageUrl,
                          activity: widget.activityName,
                          distance: widget.distance,
                          description: widget.description
                      )
                  )
              );
              // Action when the card is tapped
            },
          ),
          ListTile(
            title: Text(widget.activityName),
            subtitle: Text(widget.distance), //Icon(Icons.near_me),
            trailing: Icon(Icons.person_outline),
            onTap: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ActivityCardPage(
                          activityImageUrl: widget.imageUrl,
                          activity: widget.activityName,
                          distance: widget.distance,
                          description: widget.description
                      )
                  )
              );
              // Action when the card is tapped
            },
          ),
        ],
      ),
    );
  }
}