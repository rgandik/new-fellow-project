import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:frontend/widgets/myButton.dart';

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
  String _groupLink = '';
  String _category = '';
  XFile? _imageFile;
  double _maxParticipants = 10;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
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
                  onPressed: () {
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
