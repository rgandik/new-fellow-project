import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/FindYourCircle.dart';

class FindYourCircle extends StatelessWidget {
  const FindYourCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(
                'assets/icons/progress1.svg',
                height: 100,
                width: 20,
              ),
            ),
            const Text(
              "Where Are You Located?",
              style: TextStyle(fontSize: 30),
            ),
            // Wrap()
            const SizedBox(height: 20),
            _searchAndAddField(),
          ],
        ));
  }

  Container _searchAndAddField() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 30,
        right: 20,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    'assets/icons/Search.svg',
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    'assets/icons/Filter.svg',
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // ElevatedButton(
          //   onPressed: () {
          //     // Handle button press
          //   },
          GestureDetector(
            onTap: () {
              print("Tapped on AddCommunity");
            },
            child: SvgPicture.asset(
              'assets/icons/AddCommunity.svg',
              height: 50,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'City Circle',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color(0xFF19747E),
      // elevation: 10.0,
      leading: GestureDetector(
        onTap: () {
          print("Tapped on Back Arrow");
          Navigator.of(context).pop();
        },
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Back Arrow.svg',
            height: 35,
          ),
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("Tapped on Front Arrow");
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FindYourCircle()));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/Front Arrow.svg',
              height: 35,
            ),
            decoration: BoxDecoration(
              // color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
