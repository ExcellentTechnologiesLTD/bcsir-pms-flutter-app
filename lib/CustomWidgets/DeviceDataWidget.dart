import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceDataWidget extends StatelessWidget {
  String DeviceID = "";
  int SPo2 = 0;

  int BPM = 0;

  var dangerColor = 0xffee0b0b;
  var normalColor = 0xFF22C645;
  var disabledColor = 0xff99a19b;
  var setColor;
  bool noFinger = false;

  DeviceDataWidget(
      {required this.DeviceID, required this.SPo2, required this.BPM, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SPo2 == BPM && SPo2 < -10 && BPM < -10) {
      noFinger = true;
    }
    if ((SPo2 < 90 || BPM < 60) && DeviceID != "") {
      setColor = dangerColor;
    } else if (DeviceID == "" && SPo2 == 0 && BPM == 0) {
      setColor = disabledColor;
    } else {
      setColor = normalColor;
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(setColor)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: !noFinger
            ? Column(
                children: [
                  Text(
                    "Device ID: " + DeviceID,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "SPo2: " + SPo2.toString() + " %",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "BPM: " + BPM.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )
            : Column(
                children: [
                  Text(
                    "Device ID: " + DeviceID,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No Finger!!!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
      ),
    );
  }
}
