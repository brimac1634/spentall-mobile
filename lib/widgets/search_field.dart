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
        print('whats up');
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
      onSubmitted: (String value) async {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thanks!'),
              content: Text('You typed "$value".'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Search',
      ),
    );
  }
}
