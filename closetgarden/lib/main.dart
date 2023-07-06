import 'package:flutter/material.dart';
import 'Second.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Closet Garden'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Text(
                'Silly',
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: MyFloatingActionButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as per your requirement
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Adjust the borderRadius as needed
          ),
          backgroundColor:
          Colors.indigoAccent, // Set the background color using the primary property
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Connect Garden',
            style: TextStyle(fontSize: 16), // Adjust the font size as needed
          ),
        ),
      ),
    );
  }
}