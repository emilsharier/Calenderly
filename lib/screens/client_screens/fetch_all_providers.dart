import 'package:calenderly/models/provider.dart';
import 'package:calenderly/providers/api_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchAllProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiInterface>(context);
    return Container(
      child: FutureBuilder<List<ProviderModel>>(
        future: provider.fetchAllProviders(),
        builder: (context, snapshot) {
          Widget _child;
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<ProviderModel> data = snapshot.data;
            _child = ListView(
              children: data.map((e) {
                return ListTile(
                  title: Text(e.name),
                );
              }).toList(),
            );
          } else if (!snapshot.hasData) {
            _child = Text('no data');
          } else
            _child = Text('loading');

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: _child,
          );
        },
      ),
    );
  }
}
