import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/widgets/myButton.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

// Constants
const kBorderRadius = 10.0;
const kHintColor = Colors.grey;
const kTextFieldFillColor = Colors.white;

class CreateCircleScreen extends StatefulWidget {
  @override
  _CreateCircleScreenState createState() => _CreateCircleScreenState();
}

class _CreateCircleScreenState extends State<CreateCircleScreen> {
  final _formKey = GlobalKey<FormState>();
  String _activityName = '';
  String _eventDescription = '';
  DateTime _eventDate = DateTime.now();
  TimeOfDay _eventTime = TimeOfDay.now();
  String _location = '';
  late double latitude;
  late double longitude;
  String _groupLink = '';
  String _linkType = '';
  String _category = '';
  XFile? _imageFile;
  double _maxParticipants = 10;
  //String uid = AuthProvider().uid()!;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> getLocation() async {
    List<Location> tempLocation = (await locationFromAddress(_location));
    /*if (tempLocation[0].latitude.isNaN) {
      return false;
    } else {
      return true;
    }*/
    latitude = double.parse(tempLocation[0].latitude.toString());
    longitude = double.parse(tempLocation[0].longitude.toString());
    print(latitude);
    print(longitude);
  }

  Future<bool> createCircle(String activity, String description, int day, int month, int year, int hour, int minute, double latitude, double longitude, String gcUrl, List<String> categories, String uid, double size) async {
    var url = 'https://new-fellow-project.vercel.app/groups';

    final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'activity': activity,
          'description': description,
          'day': day,
          'month': month,
          'year': year,
          'hour': hour,
          'minute': minute,
          'latitude': latitude,
          'longitude': longitude,
          'gcUrl': gcUrl,
          'categories': categories,
          'users': [uid],
          'size': size,
          'imageUrl': 'https://picsum.photos/200'
        })
    );
    if (response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      print("Error creating group");
      print(response.body);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create a Circle',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Max Amount Of Participants',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _maxParticipants,
                        min: 2,
                        max: 50,
                        divisions: 48,
                        label: _maxParticipants.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _maxParticipants = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      _maxParticipants.round().toString(),
                      style: const TextStyle(color: kHintColor),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Activity Name',
                    hintText: 'Please enter an activity name',
                    hintStyle: TextStyle(color: kHintColor),
                    fillColor: kTextFieldFillColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an activity name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _activityName = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Describe your event',
                    hintText: 'Please describe your event',
                    hintStyle: TextStyle(color: kHintColor),
                    fillColor: kTextFieldFillColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please describe your event';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _eventDescription = value!;
                  },
                ),
                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _eventDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _eventDate = pickedDate;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 8),
                            Text(
                              '${_eventDate.month}/${_eventDate.day}/${_eventDate.year}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          '${_eventTime.hourOfPeriod.toString().padLeft(2, '0')}:${_eventTime.minute.toString().padLeft(2, '0')} ${_eventTime.period.name.toUpperCase()}',
                        ),
                        trailing: Icon(Icons.access_time),
                        onTap: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: _eventTime,
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _eventTime = pickedTime;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Please enter a location',
                    hintStyle: TextStyle(color: kHintColor),
                    fillColor: kTextFieldFillColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _location = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'GroupMe, Slack, or Discord Link',
                    hintText: 'Insert invite link here',
                    hintStyle: TextStyle(color: kHintColor),
                    fillColor: kTextFieldFillColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  onSaved: (value) {
                    _groupLink = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Link Type',
                    hintText: 'Please enter the link type (GroupMe, Slack, etc.)',
                    hintStyle: TextStyle(color: kHintColor),
                    fillColor: kTextFieldFillColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the link type (GroupMe, Slack, etc.)';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _linkType = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    hintText: 'Put interest categories separated by commas',
                    hintStyle: TextStyle(color: kHintColor),
                    fillColor: kTextFieldFillColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  onSaved: (value) {
                    _category = value!;
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: InkWell(
                    onTap: () async {
                      await _pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: _imageFile == null
                          ? Icon(Icons.camera_alt, size: 50)
                          : Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          await _pickImage(ImageSource.camera);
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text('Take a Picture'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          await _pickImage(ImageSource.gallery);
                        },
                        icon: Icon(Icons.image),
                        label: Text('Upload from Gallery'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                myButton(
                  width: 3000,
                  text: 'Create Circle',
                  onPressed: () async {
                    AuthProvider authProvider = Provider.of<AuthProvider>(context,
                        listen: false);
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Perform the necessary actions with the form data
                      print('Activity Name: $_activityName');
                      print('Event Description: $_eventDescription');
                      print('Event Time: ${_eventTime.format(context)}');
                      print('Location: $_location');
                      print('Group Link: $_groupLink');
                      print('Max Participants: $_maxParticipants');
                      print('Image File: ${_imageFile?.path}');
                    }
                    await getLocation();
                    bool created = await createCircle(
                      _activityName,
                      _eventDescription,
                      _eventDate.day,
                      _eventDate.month,
                      _eventDate.year,
                      _eventTime.hour,
                      _eventTime.minute,
                      latitude,
                      longitude,
                      _groupLink,
                      [_category],
                      authProvider.uid()!,
                      _maxParticipants
                    );
                    if (created == true) {
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 34),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
