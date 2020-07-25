import 'package:calenderly/screens/client_screens/client_schedules.dart';
import 'package:calenderly/screens/client_screens/fetch_all_providers.dart';
import 'package:flutter/material.dart';

class ClientDashboard extends StatefulWidget {
  @override
  _ClientDashboardState createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Your schedules'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text('Profile'),
          ),
        ],
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    Widget _child;
    switch (index) {
      case 0:
        _child = ClientSchedules();
        break;
      case 1:
        _child = FetchAllProviders();
        break;
      case 2:
        _child = Text('2');
        break;
      default:
        _child = Text('0');
        break;
    }
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: _child,
    );
  }
}
