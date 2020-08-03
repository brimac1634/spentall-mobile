import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: Text(
          '100%',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
