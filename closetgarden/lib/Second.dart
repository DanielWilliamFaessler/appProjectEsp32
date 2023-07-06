import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:convert';

class Second extends StatefulWidget{
  @override
  _Second createState()=> _Second();
}

final broker = 'broker.mqttdashboard.com';
final port = 1883;
final topic = 'garden/sensor';
final clientIdentifier = 'flutter';

class _Second extends State<Second>{

  String receivedMessage = '';
  String temp = '';
  String humidity = '';
  MqttServerClient client = MqttServerClient(broker, clientIdentifier);

  @override
  void initState() {
    super.initState();
    connectDevice();
  }

  void connectDevice() async {
    client.port = port;
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

  void messageReceived(String topic, MqttMessage message) {
    if (message is MqttPublishMessage) {
      String payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      setState(() {
        receivedMessage = payload;
        Map<String, dynamic> jsonMap = jsonDecode(receivedMessage);
        double humidities = jsonMap['humidity'];
        jsonMap.remove('humidity');
        double temperative = jsonMap['temp'];
        jsonMap.remove('temp');
        humidity = '$humidities';
        temp = '$temperative';

      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Closet Garden'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The temperature is: $temp'),
            Text('The humidity is: $humidity'),
          ],
        ),
      ),
    );
  }
}