import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

void connectDevice(){

}

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as per your requirement
      child: ElevatedButton(
        onPressed: () {
          connectDevice();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Adjust the borderRadius as needed
          ),
          backgroundColor: Colors.indigoAccent, // Set the background color using the primary property
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

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Closet Garden'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
            child: Container(
              child: Center(
                child: Text(
                  'hi'
                ),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
