import 'package:flutter/material.dart';
import './questions.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String _title = '';
  String _subtitle = '';
  int counter = 0;
  Question q = Question(category: '', subcategory: '');
  // List result = List.filled(29, 0, growable: false);

  bool toggle = false;
  List<bool> isSelected = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    print('BUILD Function called');
    if (counter <= 28) {
      _title = q.getQuestionbyID(counter).category;
      _subtitle = q.getQuestionbyID(counter).subcategory;
    }

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        _title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        _subtitle,
                        textAlign: TextAlign.center,
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
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Center(
                    child: ToggleButtons(
                        color: Colors.cyan,
                        children: [
                          ImageIcon(
                            AssetImage("assets/notfound_1.png"),
                            size: 240,
                          ),
                          ImageIcon(
                            AssetImage("assets/notfound_1.png"),
                            size: 240,
                          ),
                          ImageIcon(
                            AssetImage("assets/notfound_1.png"),
                            size: 240,
                          ),
                          ImageIcon(
                            AssetImage("assets/notfound_1.png"),
                            size: 240,
                          ),
                          ImageIcon(
                            AssetImage("assets/notfound_1.png"),
                            size: 240,
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < isSelected.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                              } else {
                                isSelected[buttonIndex] = false;
                              }
                            }
                          });
                        },
                        isSelected: isSelected),
                  ),
                )

                // evtl custom Buttons um Abstand zw den Buttons zu haben
                // (ist mit ToggleButtons nicht möglich :( )
                // IconButton(
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   padding: EdgeInsets.all(0),
                //   color: toggle ? Colors.amberAccent : Colors.cyan,
                //   onPressed: () {
                //     print("PRESSED1");
                //     setState(() {
                //       toggle = !toggle;
                //     });
                //   },
                //   iconSize: 240,
                //   icon: ImageIcon(
                //     AssetImage("assets/notfound_1.png"),
                //   ),
                // ),
                // IconButton(
                //   padding: EdgeInsets.all(0),
                //   onPressed: () {
                //     print("PRESSED2");
                //   },
                //   iconSize: 240,
                //   icon: ImageIcon(
                //     AssetImage("assets/notfound_1.png"),
                //     color: Colors.cyan,
                //   ),
                // ),
                // IconButton(
                //   padding: EdgeInsets.all(0),
                //   onPressed: () {
                //     print("PRESSED3");
                //   },
                //   iconSize: 240,
                //   icon: ImageIcon(
                //     AssetImage("assets/notfound_1.png"),
                //     color: Colors.cyan,
                //   ),
                // ),
                // IconButton(
                //   padding: EdgeInsets.all(0),
                //   onPressed: () {
                //     print("PRESSED4");
                //   },
                //   iconSize: 240,
                //   icon: ImageIcon(
                //     AssetImage("assets/notfound_1.png"),
                //     color: Colors.cyan,
                //   ),
                // ),
                // IconButton(
                //   padding: EdgeInsets.all(0),
                //   onPressed: () {
                //     print("PRESSED5");
                //   },
                //   iconSize: 240,
                //   icon: ImageIcon(
                //     AssetImage("assets/notfound_1.png"),
                //     color: Colors.cyan,
                //   ),
                // ),
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
                    heroTag: 'btnback',
                    onPressed: () {
                      if (counter <= 0) {
                        Navigator.pop(context);
                      }
                      setState(() {
                        if (counter > 0) counter -= 1;
                      });
                    },
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
                    heroTag: 'btnforward',
                    onPressed: () {
                      if (counter >= 28) {
                        Navigator.pushNamed(
                          context,
                          '/result',
                          arguments: q.result,
                        );
                      }
                      setState(() {
                        if (counter <= 29) counter += 1;
                        q.result[counter - 1] = isSelected.indexOf(true) + 1;

                        print(q.result);
                        isSelected = [false, false, false, false, false];
                      });

                      // Navigator.pushNamed(context, '/question');
                    },
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
