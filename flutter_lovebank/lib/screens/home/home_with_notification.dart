import 'package:flutter/material.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/screens/home/home_widget.dart';
import 'package:flutterapp/services/push_notification_handler.dart';
import 'package:provider/provider.dart';


class CompleteHome extends StatefulWidget {
  CompleteHome();

  @override
  _CompleteHomeState createState() => _CompleteHomeState();
}

class _CompleteHomeState extends State<CompleteHome> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    ChallengePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User localUser = Provider.of<User>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MessageHandler(), //background of home 
          _widgetOptions.elementAt(_selectedIndex), //top layer - Changes with bottom navigation bar selection
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text('Challenge'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple[300],
        onTap: _onItemTapped,
      ),
    );
  }
}
