import 'package:calenderly/models/provider_schedule_model.dart';
import 'package:calenderly/providers/api_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulesToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiInterface>(context);
    return Container(
      child: FutureBuilder<List<ProviderScheduleModel>>(
        future: provider.fetchLiveSchedules(),
        builder: (context, snapshot) {
          Widget _child;
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<ProviderScheduleModel> data = snapshot.data;
            _child = ListView(
              children: data.map((e) {
                return ListTile(
                  title: Text(e.description),
                  subtitle: Text(e.startTime.hour.toString() + ' : 00'),
                );
              }).toList(),
            );
          } else {
            _child = CircularProgressIndicator();
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: _child,
          );
        },
      ),
    );
  }
}
