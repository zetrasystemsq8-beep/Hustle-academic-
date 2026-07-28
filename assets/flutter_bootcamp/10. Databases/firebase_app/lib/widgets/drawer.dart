import 'package:flutter/material.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.deepPurple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  currentAccountPicture: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                  ),
                  accountName: Text('Muhammad Jamil'),
                  accountEmail: Text('jamil138.amin@gmail.com'),
                  margin: EdgeInsets.zero,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white,),
              title:  Text('Home', textScaleFactor: 1.2, style: TextStyle(color: Colors.white),),

              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading:  Icon(Icons.settings, color: Colors.white,),
              title:  Text('Settings', textScaleFactor: 1.2, style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
