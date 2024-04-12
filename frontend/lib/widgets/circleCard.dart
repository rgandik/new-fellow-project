import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../pages/activity_card.dart';
import 'package:geocoding/geocoding.dart';

class CircleCard extends StatefulWidget {
  final String activity;
  final double latitude;
  final double longitude;
  final String description;
  final String imageUrl;

  CircleCard({
    required this.activity,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.imageUrl
  });

  @override
  _CircleCardState createState() => _CircleCardState();
}

String location = "";

class _CircleCardState extends State<CircleCard> {


  void getLocation() async {
    String tempLocation = (await placemarkFromCoordinates(widget.latitude, widget.longitude)).first.name!;
    if(mounted) {
      setState(() => location = tempLocation);
    }
  }
  @override
  void initState() {
    super.initState();
    getLocation();
    print(widget.longitude);
    print(widget.latitude);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: Constants.width * 0.05, right: Constants.width * 0.05),
        child: Card(
          child: Column(
            children: <Widget>[
              Image.network(
                // widget.imageUrl,
                widget.imageUrl,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(widget.activity),
                subtitle: Text(location),
                trailing: Icon(Icons.person_outline),
                onTap: () async {
                  await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ActivityCardPage(
                              activityImageUrl: widget.imageUrl,
                              activity: widget.activity,
                              distance: "2",
                              description: widget.description
                          )
                      )
                  );
                  // Action when the card is tapped
                },
              ),
            ],
          ),
        ),
    );
  }
}