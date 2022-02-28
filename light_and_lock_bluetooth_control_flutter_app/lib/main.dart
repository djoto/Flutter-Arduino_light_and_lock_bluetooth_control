import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
    
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Light and Lock Remote Control App'),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _bulbImgPathLivingRoom = "images/light_off.png";
  String _bulbImgPathBedroom = "images/light_off.png"; 
  String _bulbImgPathChildrensRoom = "images/light_off.png";
  String _bulbImgPathKitchen = "images/light_off.png";
  String _bulbImgPathBathroom = "images/light_off.png";
  String _bulbImgPathHallway = "images/light_off.png";
  String _padlockImgPathFrontDoor = "images/locked.png";

  Color _clrButtonLivingRoom = Colors.green;
  Color _clrButtonBedroom = Colors.green;
  Color _clrButtonChildrensRoom = Colors.green;
  Color _clrButtonKitchen = Colors.green;
  Color _clrButtonBathroom = Colors.green;
  Color _clrButtonHallway = Colors.green;
  Color _clrButtonFrontDoor = Colors.green;

  String _txtButtonLivingRoom = "TURN ON";
  String _txtButtonBedroom = "TURN ON";
  String _txtButtonChildrensRoom = "TURN ON";
  String _txtButtonKitchen = "TURN ON";
  String _txtButtonBathroom = "TURN ON";
  String _txtButtonHallway = "TURN ON";
  String _txtButtonFrontDoor = "UNLOCK";

  late BluetoothConnection connection;

  String _connectedYesNo = "Loading...";
  Color _colorConnectedYesNo = Colors.black;
  String _txtButtonCheckReload = "CHECK";

  _MyHomePageState(){
    _connect();
  }

  bool get isConnected => (connection.isConnected);

  Future<void> _connect() async {
    try {
      connection = await BluetoothConnection.toAddress("00:21:07:00:07:EE");
      Fluttertoast.showToast( msg: 'Connected to the bluetooth device', );
      print('Connected to the bluetooth device');
      setState(() {
        _connectedYesNo = "Connected.";
        _colorConnectedYesNo = Colors.green;
        _txtButtonCheckReload = "CHECK";
      });
    }
    catch (exception) {
      try {
        if (isConnected){
          Fluttertoast.showToast( msg: 'Already connected to the device', );
          print('Already connected to the device');
          setState(() {
            _connectedYesNo = "Connected.";
            _colorConnectedYesNo = Colors.green;
            _txtButtonCheckReload = "CHECK";
          });
        }
        else{
          Fluttertoast.showToast( msg: 'Cannot connect, exception occured', );
          print('Cannot connect, exception occured');
          setState(() {
            _connectedYesNo = "Not connected!";
            _colorConnectedYesNo = Colors.red;
            _txtButtonCheckReload = "RELOAD";
          });
        }
      }
      catch (e){
        Fluttertoast.showToast( msg: 'Cannot connect, probably not initialized connection', );
        print('Cannot connect, probably not initialized connection');
        setState(() {
          _connectedYesNo = "Not connected!";
          _colorConnectedYesNo = Colors.red;
          _txtButtonCheckReload = "RELOAD";
        });
      }
    }
  }

  void waitLoading(){
    setState(() {
      _connectedYesNo = "Loading...";
      _colorConnectedYesNo = Colors.black;
      _txtButtonCheckReload = "CHECK";
    });
  }

  void _reloadOrCheck(){
    waitLoading();
    _connect();
  }

  Future<void> _sendData(String data) async {
      connection.output.add(Uint8List.fromList(utf8.encode(data))); // Sending data
      await connection.output.allSent;
  }  

  void _setLightOrLockState(String _roomOrDoorType){

    if(_connectedYesNo == "Connected."){

      setState(() {

        if (_roomOrDoorType == "Living Room"){
          if (_bulbImgPathLivingRoom == "images/light_off.png" && _clrButtonLivingRoom == Colors.green && _txtButtonLivingRoom == "TURN ON"){
            _bulbImgPathLivingRoom = "images/light_on.png";
            _clrButtonLivingRoom = Colors.red;
            _txtButtonLivingRoom = "TURN OFF";
            _sendData("a");
          }
          else{
            _bulbImgPathLivingRoom = "images/light_off.png";
            _clrButtonLivingRoom = Colors.green;
            _txtButtonLivingRoom = "TURN ON";
            _sendData("b");
          }
        } 
        else if (_roomOrDoorType == "Bedroom"){
          if (_bulbImgPathBedroom == "images/light_off.png" && _clrButtonBedroom == Colors.green && _txtButtonBedroom == "TURN ON"){
            _bulbImgPathBedroom = "images/light_on.png";
            _clrButtonBedroom = Colors.red;
            _txtButtonBedroom = "TURN OFF";
            _sendData("c");
          }
          else{
            _bulbImgPathBedroom = "images/light_off.png";
            _clrButtonBedroom = Colors.green;
            _txtButtonBedroom = "TURN ON";
            _sendData("d");
          }
        }
        else if (_roomOrDoorType == "Children's Room"){
          if (_bulbImgPathChildrensRoom == "images/light_off.png" && _clrButtonChildrensRoom == Colors.green && _txtButtonChildrensRoom == "TURN ON"){
            _bulbImgPathChildrensRoom = "images/light_on.png";
            _clrButtonChildrensRoom = Colors.red;
            _txtButtonChildrensRoom = "TURN OFF";
            _sendData("e");
          }
          else{
            _bulbImgPathChildrensRoom = "images/light_off.png";
            _clrButtonChildrensRoom = Colors.green;
            _txtButtonChildrensRoom = "TURN ON";
            _sendData("f");
          }
        }
        else if (_roomOrDoorType == "Kitchen"){
          if (_bulbImgPathKitchen == "images/light_off.png" && _clrButtonKitchen == Colors.green && _txtButtonKitchen == "TURN ON"){
            _bulbImgPathKitchen = "images/light_on.png";
            _clrButtonKitchen = Colors.red;
            _txtButtonKitchen = "TURN OFF";
            _sendData("g");
          }
          else{
            _bulbImgPathKitchen = "images/light_off.png";
            _clrButtonKitchen = Colors.green;
            _txtButtonKitchen = "TURN ON";
            _sendData("h");
          }
        }
        else if (_roomOrDoorType == "Bathroom"){
          if (_bulbImgPathBathroom == "images/light_off.png" && _clrButtonBathroom == Colors.green && _txtButtonBathroom == "TURN ON"){
            _bulbImgPathBathroom = "images/light_on.png";
            _clrButtonBathroom = Colors.red;
            _txtButtonBathroom = "TURN OFF";
            _sendData("i");
          }
          else{
            _bulbImgPathBathroom = "images/light_off.png";
            _clrButtonBathroom = Colors.green;
            _txtButtonBathroom = "TURN ON";
            _sendData("j");
          }
        }
        else if (_roomOrDoorType == "Hallway"){
          if (_bulbImgPathHallway == "images/light_off.png" && _clrButtonHallway == Colors.green && _txtButtonHallway == "TURN ON"){
            _bulbImgPathHallway = "images/light_on.png";
            _clrButtonHallway = Colors.red;
            _txtButtonHallway = "TURN OFF";
            _sendData("k");
          }
          else{
            _bulbImgPathHallway = "images/light_off.png";
            _clrButtonHallway = Colors.green;
            _txtButtonHallway = "TURN ON";
            _sendData("l"); // letter l !!!
          }
        }
        else if (_roomOrDoorType == "Front Door"){
          if (_padlockImgPathFrontDoor == "images/locked.png" && _clrButtonFrontDoor == Colors.green && _txtButtonFrontDoor == "UNLOCK"){
            _padlockImgPathFrontDoor = "images/unlocked.png";
            _clrButtonFrontDoor = Colors.red;
            _txtButtonFrontDoor = "LOCK";
            _sendData("m");
          }
          else{
            _padlockImgPathFrontDoor = "images/locked.png";
            _clrButtonFrontDoor = Colors.green;
            _txtButtonFrontDoor = "UNLOCK";
            _sendData("n");
          }
        }
      });
    }
    else{
      Fluttertoast.showToast( msg: 'Cannot send data!\nYou are not connected.', );
    }
  }
  
  Widget _buildRow(String _roomOrDoorType, String _imagePath, Color _clrButton, String _txtButton) {
    return Container (
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          Image.asset(
            _imagePath,
            height: 50.0,
            width: 50.0,
          ),
          Expanded(child: Text(_roomOrDoorType, style: const TextStyle(fontSize: 20))),
          SizedBox(
            width: 100.0,
            child: ElevatedButton(
              onPressed: () { _setLightOrLockState(_roomOrDoorType); }, 
              child: Text(
                _txtButton,
                style: const TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(_clrButton)),
            ),
          ),
        ],
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.lightBlue[100],
        child: SingleChildScrollView(
            child: Column(
            children: [
              _buildRow("Living Room", _bulbImgPathLivingRoom, _clrButtonLivingRoom, _txtButtonLivingRoom),
              _buildRow("Bedroom", _bulbImgPathBedroom, _clrButtonBedroom, _txtButtonBedroom),
              _buildRow("Children's Room", _bulbImgPathChildrensRoom, _clrButtonChildrensRoom, _txtButtonChildrensRoom),
              _buildRow("Kitchen", _bulbImgPathKitchen, _clrButtonKitchen, _txtButtonKitchen),
              _buildRow("Bathroom", _bulbImgPathBathroom, _clrButtonBathroom, _txtButtonBathroom),
              _buildRow("Hallway", _bulbImgPathHallway, _clrButtonHallway, _txtButtonHallway),
              _buildRow("Front Door", _padlockImgPathFrontDoor, _clrButtonFrontDoor, _txtButtonFrontDoor),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                padding: const EdgeInsets.fromLTRB(45.0, 10.0, 50.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(_connectedYesNo, style: TextStyle(fontSize: 20, color: _colorConnectedYesNo))),
                    SizedBox(
                      width: 100.0,
                      child: ElevatedButton(
                        onPressed: _reloadOrCheck, 
                        child: Text(
                          _txtButtonCheckReload,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
