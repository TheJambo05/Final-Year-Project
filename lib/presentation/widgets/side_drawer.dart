import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 85,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.person,
            ),
            title: const Text('Account'),
            onTap: () {
              // Add navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.app_registration,
            ),
            title: const Text('App Registration'),
            onTap: () {
              // Add navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text('Settings'),
            onTap: () {
              // Add navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more list tiles for additional options
        ],
      ),
    );
  }
}
