import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack allows widgets to be on top of each other ( for the logo in the top right corner)
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Container(
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/Logo.png",
                  width: 200,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 60, 40, 40),
                  child: Text(
                    'Agogische Dokumentation',
                    style: TextStyle(
                        fontSize: 56,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 35, 50, 35),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                      hint: Text("Einrichtung wählen"),
                      items: <String>['A', 'B', 'C', 'D'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: 500,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Passwort",
                            suffixIcon: Icon(Icons.remove_red_eye),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                            border: OutlineInputBorder()),
                        obscureText: true,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      onPressed: () {
                        Navigator.pushNamed(context, '/question');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
