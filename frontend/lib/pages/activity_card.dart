import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/pages/explore_screen.dart';
import 'package:frontend/pages/login_screen.dart';
import 'package:frontend/widgets/myButton.dart';
import 'package:url_launcher/url_launcher.dart';

// Define a global variable for horizontal margin
const double horizontalMargin = 25.0;

class ActivityCardPage extends StatefulWidget {
  final String activityImageUrl;
  final String activity;
  final String distance;
  final String description;
  final String linkType;
  final String groupLink;

  ActivityCardPage({
    Key? key,
    required this.activityImageUrl,
    required this.activity,
    required this.distance,
    required this.description,
    required this.linkType,
    required this.groupLink,
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
            flex: 2,
            child: Image.network(
              widget.activityImageUrl,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(horizontalMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.activity,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Navigation.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '${widget.distance} miles away',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Person.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '45',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/message.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 6),
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunchUrl(Uri.parse(widget.groupLink))) {
                            await launchUrl(Uri.parse(widget.groupLink));
                          } else {
                            throw 'Could not launch ${widget.groupLink}';
                          }
                        },
                        child: Text(
                          widget.linkType,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myButton(
                            text: 'Join Circle',
                            onPressed: () {
                              print('Join Circle Button pressed');
                              Navigator.of(context).pop();
                            },
                            width: 3000,
                          ),
                          SizedBox(height: 19),
                          SizedBox(
                            width: 3000,
                            height: 41,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                print('Go Back button pressed');
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                "Go Back",
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
