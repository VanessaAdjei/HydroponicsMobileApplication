import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'home_screen.dart';

class Control extends StatefulWidget {
  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  //const SecondRouteRoute({Key key}) : super(key: key);

  late bool isFan;
  late bool isLight;
  late bool isWaterPump;

  @override
  void initState() {
    isFan = false;
    isLight = false;
    isWaterPump = false;

    readData();

    super.initState();
  }

  onchangeWaterPump(bool value) async {
    setState(() {
      isWaterPump = value;
    });

    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Controls/control_switches");

    await ref.update({
      "WaterPump": isWaterPump,
    });
  }

  onchangeLight(bool value) async {
    setState(() {
      isLight = value;
    });

    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Controls/control_switches");

    await ref.update({
      "Light": isLight,
    });
  }

  onchangeFan(bool value) async {
    setState(() {
      isFan = value;
    });

    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Controls/control_switches");

    await ref.update({
      "Fan": isFan,
    });
  }

  readData() {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('Controls/control_switches/');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      final formatData =
          data.toString().replaceAll('{', '').replaceAll('}', '');
      updateControls(formatData);
    });
  }

  updateControls(data) {
    var formatData = data.split(',');

    setState(() {
      isFan = formatData[0].split(':')[1].replaceAll(' ', '') == 'true'? true : false;
      isWaterPump = formatData[1].split(':')[1].replaceAll(' ', '')== 'true'? true : false;
      isLight = formatData[2].split(':')[1].replaceAll(' ', '')== 'true'? true : false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Farm'),
      ),
      body: Container(
        height: 5000,
        child: ListView(padding: const EdgeInsets.all(8), children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Control  Page',
                style: TextStyle(fontSize: 25, color: Colors.lightBlue),
              )),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),

          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),

          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),

          Container(
            child: Row(
              children: [
                Switch(
                    value: isWaterPump,
                    onChanged: (bool value) => onchangeWaterPump(value)),
                Center(
                  child: Text(
                    "Water pump control",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          ),

          Container(
            child: Row(
              children: [
                Switch(
                    value: isLight,
                    onChanged: (bool value) => onchangeLight(value)),
                Center(
                  child: Text(
                    "Light control",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          ),

          Container(
            child: Row(
              children: [
                Switch(
                    value: isFan,
                    onChanged: (bool value) => onchangeFan(value)),
                Center(
                  child: Text(
                    "Fan control",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          ),
          // Container(
          //   color: Colors.white,
          //   child: ToggleSwitch(
          //     minWidth: 220.0,
          //     cornerRadius: 20.0,
          //     activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
          //     activeFgColor: Colors.white,
          //     inactiveBgColor: Colors.grey,
          //     inactiveFgColor: Colors.white,
          //     initialLabelIndex: 1,
          //     totalSwitches: 2,
          //     labels: ['On water pump', 'Off water pump'],
          //     radiusStyle: true,
          //     onToggle: (index) {
          //       setState(() {
          //
          //       });
          //       print('switched to: $isWaterPump');
          //     },
          //   ),
          // ),
          //
          //
          // Container(
          //   height: 20,
          //   color: Color.fromARGB(255, 252, 251, 250),
          // ),
          //
          // Container(
          //   color: Colors.white,
          //   child: ToggleSwitch(
          //     minWidth: 220.0,
          //     cornerRadius: 20.0,
          //     activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
          //     activeFgColor: Colors.white,
          //     inactiveBgColor: Colors.grey,
          //     inactiveFgColor: Colors.white,
          //     initialLabelIndex: 1,
          //     totalSwitches: 2,
          //     labels: ['On light', 'Off light'],
          //     radiusStyle: true,
          //     onToggle: (index) {
          //       print('switched to: $index');
          //     },
          //   ),
          // ),
          //
          // Container(
          //   height: 20,
          //   color: Color.fromARGB(255, 252, 251, 250),
          // ),

          // Container(
          //   color: Colors.white,
          //   child: ToggleSwitch(
          //     minWidth: 220.0,
          //     cornerRadius: 20.0,
          //     activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
          //     activeFgColor: Colors.white,
          //     inactiveBgColor: Colors.grey,
          //     inactiveFgColor: Colors.white,
          //     initialLabelIndex: 1,
          //     totalSwitches: 2,
          //     labels: ['On fan', 'Off fan'],
          //     radiusStyle: true,
          //     onToggle: (index) {
          //       print('switched to: $index');
          //     },
          //   ),
          // ),

          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),

          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Container(
            height: 20,
            color: Color.fromARGB(255, 252, 251, 250),
          ),
          Row(
            children: <Widget>[
              const Text('Want to go back to monitoring page'),
              TextButton(
                child: const Text(
                  'Monitoring Page',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home_Screen()),
                  );
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ]),
      ),
    );
  }
}
