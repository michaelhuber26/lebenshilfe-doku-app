import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange[900]),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agogische Dokumentation'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageIcon(
                  AssetImage("assets/notfound_1.png"),
                  color: Colors.orange,
                  size: 250,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        '1.) Lernen und Wissensanwendung',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        'Elementares Lernen (Lesen, Rechnen, Schreiben)',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                ImageIcon(
                  AssetImage("assets/notfound_1.png"),
                  color: Colors.orange,
                  size: 250,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageIcon(
                  AssetImage("assets/notfound_1.png"),
                  color: Colors.cyan,
                  size: 240,
                ),
                ImageIcon(
                  AssetImage("assets/notfound_1.png"),
                  color: Colors.cyan,
                  size: 240,
                ),
                ImageIcon(
                  AssetImage("assets/notfound_1.png"),
                  color: Colors.cyan,
                  size: 240,
                ),
                ImageIcon(
                  AssetImage("assets/notfound_1.png"),
                  color: Colors.cyan,
                  size: 240,
                ),
                ImageIcon(
                  AssetImage("assets/notfound_1.png"),
                  color: Colors.cyan,
                  size: 240,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.deepPurple,
                      size: 80,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.black.withOpacity(0),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepPurple,
                      size: 80,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.black.withOpacity(0),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
