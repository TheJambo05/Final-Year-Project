import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(
              'John Doe', // Replace with user's name
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            accountEmail: const Text(
              'johndoe@example.com', // Replace with user's email
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: const Text(
              'Account',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              // Add navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
          const Divider(), // Add divider
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              // Add navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
          const Divider(), // Add divider
          ListTile(
            leading: const Icon(
              Icons.lock,
              color: Colors.black,
            ),
            title: const Text(
              'Change Password',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              // Add navigation logic for changing password
              Navigator.pop(context); // Close the drawer
              // Navigate to change password screen
              // Example: Navigator.pushNamed(context, '/change_password');
            },
          ),
          const Divider(), // Add divider
          ListTile(
            leading: const Icon(
              Icons.help,
              color: Colors.black,
            ),
            title: const Text(
              'Help & Feedback',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              // Add navigation logic for help & feedback
              Navigator.pop(context); // Close the drawer
              // Navigate to help & feedback screen
              // Example: Navigator.pushNamed(context, '/help_feedback');
            },
          ),
          const Divider(), // Add divider
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              // Show confirmation dialog before logout
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                          // Perform logout actions
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
