import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

const broker = 'broker.mqttdashboard.com';
const port = 1883;
const topic = 'garden/sensor';
const clientIdentifier = 'flutter';
final client = MqttServerClient(broker, clientIdentifier);

String receivedMessage = '';

void main() {
  // sets port
  client.port=port;
  runApp(MyApp());
}

//Debug whether Values are received by Flutter app
void messageReceived(String topic, MqttMessage message) {
  if (message is MqttPublishMessage) {
    String payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
    setState(() {
      receivedMessage = payload;
    });
  }
}

//handles the mqtt subscribe to topic
void connectDevice() async {
  await client.connect();
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('Connected to broker');
    client.subscribe(topic, MqttQos.exactlyOnce);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      for (MqttReceivedMessage<MqttMessage> message in messages) {
        messageReceived(message.topic, message.payload);
      }
    });
  }
}

//Styling FloatingActionButton
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
//
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
  String receivedMessage = '';

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
                receivedMessage,
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
