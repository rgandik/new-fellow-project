import 'package:flutter/material.dart';
import '../widgets/circle_card.dart';
import '../constants.dart';
import 'create_circle.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExploreScreen extends StatefulWidget {
  @override
  ExploreScreenState createState() => ExploreScreenState();
}

class ExploreScreenState extends State<ExploreScreen> {
  // Example list of circle data; replace with your own data source
  List<Map<String, dynamic>> circlesData = [];
  void getUserCircles() async {
    var url = 'https://new-fellow-project.vercel.app/groups';

    final response = await http.get(Uri.parse(url));
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
        toolbarHeight: 90
      ),
      body: CustomScrollView(
        slivers: [
          /*const SliverToBoxAdapter(
            child: SizedBox(
              height: 10
            ),
          ),*/
          SliverAppBar(
            pinned: true,
            title: Padding(
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
            )
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30
            )
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListView.builder(
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics()
                )
              ]
            )
          )
        ]
      )
    );
  }
}