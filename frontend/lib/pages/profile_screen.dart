import 'package:flutter/material.dart';
import 'package:frontend/pages/profile_edit_screen.dart';
import 'package:frontend/pages/login_screen.dart';

import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          // Add an icon or widget for notifications (if needed)
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add functionality for notifications
            },

          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/images/profileimage.png'),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("Edit Profile Pressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileEditScreen()),
                    );
                  },
                  child: Text('Edit Profile'),
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'General',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: Text('History'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for history
                },
              ),
              ListTile(
                title: Text('Interests'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for interests
                },
              ),
              ListTile(
                title: Text('Account'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  AuthService().signOut();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => LoginScreen()),
                  // );
                  // Add functionality for account
                },
              ),
              ListTile(
                title: Text('Circles'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for circles
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Liked'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for liked items
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('Download'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for downloads
                },
              ),
              SizedBox(height: 32.0),
              Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Language'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for language settings
                },
              ),
              ListTile(
                leading: Icon(Icons.brightness_4),
                title: Text('Darkmode'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for dark mode
                },
              ),
              ListTile(
                leading: Icon(Icons.wifi),
                title: Text('Only Download via WiFi'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Add functionality for download settings
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}