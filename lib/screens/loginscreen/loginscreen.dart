import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> _einrichungenList = ['A', 'B', 'C', 'D'];
  String? dropdownValue;

  // Initially password is obscure
  bool _obscureText = true;

  late String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      value: dropdownValue,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                      hint: Text("Einrichtung wählen"),
                      items: _einrichungenList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: 500,
                      child: new Column(
                        children: <Widget>[
                          new TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                icon: const Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: const Icon(Icons.lock))),
                            validator: (val) =>
                                val!.length < 6 ? 'Password too short.' : null,
                            onSaved: (val) => _password = val!,
                            obscureText: _obscureText,
                          ),
                          new FlatButton(
                              onPressed: _toggle,
                              child: new Text(_obscureText ? "Show" : "Hide"))
                        ],
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
