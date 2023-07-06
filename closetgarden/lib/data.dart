import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Closet Garden'),
      ),
      body: Center(
        child: Text('This is the second screen'),
      ),
    );
  }
}