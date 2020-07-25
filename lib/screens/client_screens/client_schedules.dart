import 'package:calenderly/models/client_schedule_model.dart';
import 'package:calenderly/providers/api_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientSchedules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiInterface>(context);
    provider.viewMySchedules();
    return Container(
      child: FutureBuilder<List<ClientScheduleModel>>(
        future: provider.viewMySchedules(),
        builder: (context, snapshot) {
          Widget _child;
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<ClientScheduleModel> data = snapshot.data;
            _child = ListView(
              children: data.map((e) {
                return ListTile(
                  title: Text(e.description),
                  trailing: Text(e.startTime.hour.toString() + ':00'),
                );
              }).toList(),
            );
          } else if (!snapshot.hasData) {
            _child = Text('no data');
          } else
            _child = Text('loading');

          return Stack(
            children: <Widget>[
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: _child,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
