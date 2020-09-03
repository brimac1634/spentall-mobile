import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Function onSearch;

  SearchField({@required this.onSearch});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()
      ..addListener(() {
        widget.onSearch(_searchController.text);
      });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLines: 1,
        controller: _searchController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search',
            labelStyle: TextStyle(color: Theme.of(context).canvasColor),
            filled: true,
            fillColor: Theme.of(context).backgroundColor));
  }
}
