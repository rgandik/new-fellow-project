import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/constants.dart';

class CreateCircleScreen extends StatefulWidget {
  const CreateCircleScreen({Key? key}) : super(key: key);

  @override
  _CreateCircleScreenState createState() => _CreateCircleScreenState();
}
class _CreateCircleScreenState extends State<CreateCircleScreen> {
  // Form key to validate the form
  final _formKey = GlobalKey<FormState>();
  File? _image; // Variable to hold the image file
  String? activity;
  String? description;
  String? location;
  String? time;
  String? size;
  String? category;
  // Function to simulate image upload
  Future<void> _pickImage() async {
    // Use image picker package to pick the image
    // For example:
    // final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   }
    // });
  }
  // Function to create the circle
  void _createCircle() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Take the image received from image picker and upload it to Firebase storage
      // This will likely return a link to that image (put in a groups/ folder)
      // Pass that link to data
      // Create a map of the data you want to send
      Map<String, dynamic> data = {
        'activity': activity,
        'description': description,
        //'location': location,
        //'time': time,
        'size': size,
        'categories': category,
        // 'image': image_url
        // Add other fields as necessary
      };
      // Encode the data to JSON
      String body = json.encode(data);
      // Send the POST request
      var response = await http.post(
        Uri.parse('https://new-fellow-project.vercel.app/groups'), // Change to the correct endpoint
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print('Circle created successfully');
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create circle');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Activity'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Create a Circle!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                /*showDatePicker(
                    context: context,
                    firstDate: DateTime(2000, 1, 1),
                    lastDate: DateTime(2999, 12, 31)),*/
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Activity Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity name';
                    }
                    return null;
                  },
                  onSaved: (value) => activity = value,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Describe your event',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => description = value,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => location = value,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Time',
                    border: OutlineInputBorder()
                  ),
                  onSaved: (value) => time = value,
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      labelText: 'Size',
                      border: OutlineInputBorder()
                  ),
                  onSaved: (value) => size = value,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category (Optional)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  onSaved: (value) => category = value,
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image == null
                        ? Icon(Icons.image, size: 50, color: Colors.grey[500])
                        : Image.file(_image!),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: _pickImage,
                  child: Text('Upload Image'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createCircle,
                  child: Text('Create Circle'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}