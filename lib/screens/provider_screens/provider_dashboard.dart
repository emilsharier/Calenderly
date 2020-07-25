import 'package:flutter/material.dart';

class ProviderDashboard extends StatefulWidget {
  @override
  _ProviderDashboardState createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
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
            icon: Icon(Icons.today),
            title: Text('Today'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Manage schedule'),
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
        _child = Text('0');
        break;
      case 1:
        _child = Text('1');
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
