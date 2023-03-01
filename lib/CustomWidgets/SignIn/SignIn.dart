import 'dart:convert';

import 'package:bcsir_pulse_monitoring_system/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var _email, _password;
  bool error = false;
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
              //For Logo Image
              Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/images/bcsir-logo.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child: Text(
                  "Bangladesh Council of Scientific and Industrial Research (BCSIR)",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
                //the White Container
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white,
                  ),
                  //The Sign in text
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 30, left: 10, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Email Edit Text
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Email"),
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                        ),
                        //Password Edit Text
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Password"),
                            onChanged: (value) {
                              _password = value;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        error
                            ? Text(
                                errorMsg,
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(""),
                        //The login Button
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: handleSigInBtn,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: Colors.green)),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Contact (+880)1722-433851",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSigInBtn() async {
    final response = await http.post(Uri.parse('https://bcsir-pms.xyz/signin'),
        body: {"email": _email, "pass": _password});
    print("start");
    var jsonRes = jsonDecode(response.body);
    if (jsonRes["status"] == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home()));
    } else {
      error = true;
      errorMsg = jsonRes["msg"];
    }
    print(jsonRes);
    print("end");
  }
}
