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
  List<bool> isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    print('BUILD Function called');
    if (counter <= 28) {
      _title = q.getQuestionbyID(counter).category;
      _subtitle = q.getQuestionbyID(counter).subcategory;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Agogische Dokumentation'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.credit_score_outlined),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/result',
                  // hand the result list to the result screen
                  arguments: q.result,
                );
              },
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (counter < 29)
                  Image.asset(
                    // "assets/fragen_img/q_1.png",
                    "assets/fragen_img/q_" + (counter + 1).toString() + ".png",
                    width: 250,
                    height: 250,
                  ),
                //"assets/fragen_img/q_" +
                // (counter + 1).toString() +
                // ".png"

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
                  AssetImage("assets/images/notfound_1.png"),
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
                        color: Colors.transparent,
                        fillColor: Colors.orange[100],
                        children: [
                          Image.asset(
                            "assets/images/allein_t.png",
                            width: 240,
                            height: 240,
                          ),
                          Image.asset(
                            "assets/images/mit_anleitung_t.png",
                            width: 240,
                            height: 240,
                          ),
                          Image.asset(
                            "assets/images/mit_unterstuetzung_t.png",
                            width: 240,
                            height: 240,
                          ),
                          Image.asset(
                            "assets/images/nicht_t.png",
                            width: 240,
                            height: 240,
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    heroTag: 'btnback',
                    onPressed: () {
                      if (counter <= 0) {
                        Navigator.pop(context);
                      }
                      setState(() {
                        if (counter > 0) counter -= 1;

                        // to select the piktogram which wos prior selected
                        if (q.result[counter] != 0) {
                          isSelected = [false, false, false, false];
                          isSelected[q.result[counter] - 1] = true;
                        } else
                          isSelected = [false, false, false, false];
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.deepPurple,
                      size: 65,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.black.withOpacity(0),
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    heroTag: 'btnforward',
                    onPressed: () {
                      if (counter >= 28) {
                        Navigator.pushNamed(
                          context,
                          '/result',
                          // hand the result list to the result screen
                          arguments: q.result,
                        );
                      }
                      setState(() {
                        if (counter <= 29) counter += 1;
                        // saves the number of the selected piktogram in q.result
                        q.result[counter - 1] = isSelected.indexOf(true) + 1;

                        print(q.result);
                        // select no piktogram for the new page
                        isSelected = [false, false, false, false];
                      });

                      // Navigator.pushNamed(context, '/question');
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepPurple,
                      size: 65,
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
