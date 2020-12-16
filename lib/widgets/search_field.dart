import 'package:flutter/material.dart';
import 'package:spentall_mobile/assets/spent_all_icons.dart';

import '../app_theme.dart';

class SearchField extends StatefulWidget {
  final Function onSearch;
  final String label;

  SearchField({@required this.onSearch, this.label = ''});

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
      cursorColor: AppTheme.darkPurple,
      style: AppTheme.input,
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: AppTheme.label,
          errorStyle: AppTheme.inputError,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(SpentAllIcons.search)),
    );
  }
}
