import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';

class ClientSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SearchBar(
        onSearch: null,
        onItemFound: null,
      ),
    );
  }
}
