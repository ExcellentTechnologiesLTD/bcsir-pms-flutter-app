import 'dart:async';
import 'dart:convert';
import 'package:bcsir_pulse_monitoring_system/CustomWidgets/DeviceDataWidget.dart';
import 'package:bcsir_pulse_monitoring_system/CustomWidgets/SignIn/SignIn.dart';
import 'package:bcsir_pulse_monitoring_system/CustomWidgets/Support/Support.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  var _channel;
  static const url = 'ws://bcsir-pms.xyz/';
  var data1 = null;
  var data2 = null;
  var data3 = null;
  var data4 = null;
  var data5 = null;
  var data6 = null;
  var data7 = null;
  var data8 = null;
  var data9 = null;
  var data10 = null;
  //Add a new var for new device and set it to null

  bool connected = false;

  void _toggleConnection() {
    setState(() {
      if (connected == false) {
        _channel = WebSocketChannel.connect(Uri.parse(url));
        connected = true;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Connected."),
        ));
      } else {
        _channel.sink.close();
        connected = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Disconnected."),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 180,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff0762c2), Color(0xFF093465)]),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 80,
                        width: 80,
                        child: Image.asset('assets/images/bcsir-logo.jpg'),
                      ),
                      onLongPress: () {
                        Timer(const Duration(seconds: 5), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Support()),
                          );
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Bangladesh Council of Scientific and Industrial Research (BCSIR)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: Column(
                    children: [
                      Text(
                        "Admin",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "admin@bcsir-pms.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const Support()),
                //     );
                //   },
                //   leading: Icon(
                //     Icons.headphones,
                //     color: Colors.black,
                //   ),
                //   title: Text(
                //     "Support",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("BCSIR Pulse Monitoring System"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
          child: Container(
            child: Column(
              children: [
                connected == true
                    ? ElevatedButton(
                        onPressed: _toggleConnection, child: Text("Disconnect"))
                    : ElevatedButton(
                        onPressed: _toggleConnection, child: Text("Connect")),
                _channel?.stream != null && connected == true
                    ? Text(
                        'Connected to $url',
                        style: TextStyle(color: Colors.green),
                      )
                    : Text(
                        "Disconnected",
                        style: TextStyle(color: Colors.green),
                      ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: _channel?.stream,
                  builder: (context, snapshot) {
                    String xx = snapshot.data.toString();
                    var jj = jsonDecode(xx);
                    if (jj != null) {
                      if (jj["deviceID"] == "D_0001") {
                        data1 = jj;
                      } else if (jj["deviceID"] == "D_0002") {
                        data2 = jj;
                      } else if (jj["deviceID"] == "D_0003") {
                        data3 = jj;
                      } else if (jj["deviceID"] == "D_0004") {
                        data4 = jj;
                      } else if (jj["deviceID"] == "D_0005") {
                        data5 = jj;
                      } else if (jj["deviceID"] == "D_0006") {
                        data6 = jj;
                      } else if (jj["deviceID"] == "D_0007") {
                        data7 = jj;
                      } else if (jj["deviceID"] == "D_0008") {
                        data8 = jj;
                      } else if (jj["deviceID"] == "D_0009") {
                        data9 = jj;
                      } else if (jj["deviceID"] == "D_0010") {
                        data10 = jj;
                      }
                    //  set another else if for specific device id and set new var to jj

                    }

                    // else if(jj["deviceID"] == "D_0001"){
                    //   data1=jj;
                    // }
                    return Container(
                      child: Column(
                        children: [
                          data1 != null
                              ? DeviceDataWidget(
                                  // key: data1["deviceID"],
                                  DeviceID: data1["deviceID"],
                                  SPo2: data1["SPo2"],
                                  BPM: data1["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data2 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data2["deviceID"],
                                  SPo2: data2["SPo2"],
                                  BPM: data2["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data3 != null
                              ? DeviceDataWidget(
                                  // key: data3["deviceID"],
                                  DeviceID: data3["deviceID"],
                                  SPo2: data3["SPo2"],
                                  BPM: data3["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data4 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data4["deviceID"],
                                  SPo2: data4["SPo2"],
                                  BPM: data4["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data5 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data5["deviceID"],
                                  SPo2: data5["SPo2"],
                                  BPM: data5["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data6 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data6["deviceID"],
                                  SPo2: data6["SPo2"],
                                  BPM: data6["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data7 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data7["deviceID"],
                                  SPo2: data7["SPo2"],
                                  BPM: data7["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data8 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data8["deviceID"],
                                  SPo2: data8["SPo2"],
                                  BPM: data8["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data9 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data9["deviceID"],
                                  SPo2: data9["SPo2"],
                                  BPM: data9["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),
                          data10 != null
                              ? DeviceDataWidget(
                                  // key: data2["deviceID"],
                                  DeviceID: data10["deviceID"],
                                  SPo2: data10["SPo2"],
                                  BPM: data10["BPM"])
                              : DeviceDataWidget(DeviceID: "", SPo2: 0, BPM: 0),
                          SizedBox(
                            height: 10,
                          ),

                          //set a new DeviceDataWidget with specific device ID variable
                          // for proper data display

                          // also set a new SizedBox for UI alignment


                          // DeviceDataWidget(
                          //   DeviceID: "",
                          //   SPo2: 0,
                          //   BPM: 0,
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
