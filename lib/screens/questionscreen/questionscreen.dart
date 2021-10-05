import 'package:dokumentation_lh/utils/allQuestions.dart';
import 'package:flutter/material.dart';
import '../../models/questions.dart';
import '../../services/tts_api.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String _title = '';
  String _subtitle = '';
  int counter = 0;
  TtsApi tts = TtsApi();

  // wird für selbst coded togglebuttons verwendet
  // bool toggle = false;
  bool isFavorite = false;

  List<bool> _firstClick = [true, true, true, true];
  List<bool> _isSelected = [false, false, false, false];

  late List<Question> allQuestions = getAllQuestions();

  @override
  void initState() {
    super.initState();
    tts.initTts();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD Function called');
    if (counter <= 28) {
      _title = allQuestions[counter].category;
      _subtitle = allQuestions[counter].subcategory;
    }

    void _pressedQuestion() {
      tts.speak(allQuestions[counter].subcategory);
    }

    void _pressedAnswer(int index) {
      setState(() {
        for (int btnIndex = 0; btnIndex < _isSelected.length; btnIndex++) {
          if (_firstClick[index] == true &&
              btnIndex == index &&
              _isSelected[btnIndex] == false) {
            _firstClick = [true, true, true, true];
            _isSelected = [false, false, false, false];
            _firstClick[index] = false;
            if (index == 0) tts.speak("Schaffe ich alleine");
            if (index == 1) tts.speak("Schaffe ich mit Anleitung");
            if (index == 2) tts.speak("Schaffe ich mit Unterstützung");
            if (index == 3) tts.speak("Schaffe ich nicht");
          } else if (_firstClick[index] == false && btnIndex == index) {
            _isSelected[btnIndex] = true;
            _firstClick[btnIndex] = true;
          }
          //else {
          //   _isSelected[btnIndex] = false;
          // }
        }
        print(_firstClick);
      });
    }

    void _pressedBack() {
      if (counter <= 0) {
        Navigator.pop(context);
      }
      setState(() {
        if (counter > 0) counter -= 1;

        // set favorite icon
        isFavorite = allQuestions[counter].isLiked;

        _isSelected = [false, false, false, false];
        // to select the piktogram which was prior selected
        if (allQuestions[counter].result != 0) {
          _isSelected[allQuestions[counter].result - 1] = true;
        }
      });
    }

    void _pressedFavorite() {
      isFavorite = !isFavorite;

      if (isFavorite) {
        allQuestions[counter].isLiked = true;
        tts.speak('ist mir wichtig');
      } else {
        allQuestions[counter].isLiked = false;
        tts.speak('ist mir nicht wichtig');
      }

      setState(() {});
    }

    void _pressedForward() {
      // check if all questions are answerd
      bool _allAnswerd = false;
      for (int i = 0; i < 29; i++) {
        _allAnswerd = true;
        if (allQuestions[i].result == 0) _allAnswerd = false;
      }
      if (_allAnswerd) {
        Navigator.pushNamed(
          context,
          '/result',
          // hand the result list to the result screen
          arguments: allQuestions,
        );
      } else {
        setState(() {
          if (counter < 28) counter += 1;
          // saves the number of the selected piktogram in allQuestions
          allQuestions[counter - 1].result = _isSelected.indexOf(true) + 1;

          print(allQuestions);

          if (counter < 29) isFavorite = allQuestions[counter].isLiked;

          // select no piktogram for the new page
          _isSelected = [false, false, false, false];
          // to select the piktogram which was in front selected
          if (allQuestions[counter].result != 0) {
            _isSelected[allQuestions[counter].result - 1] = true;
          }
        });
      }
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
                  arguments: allQuestions,
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
                  Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        radius: 125,
                        backgroundImage: AssetImage(
                          // "assets/fragen_img/q_1.png",
                          "assets/fragen_img/q_" +
                              (counter + 1).toString() +
                              ".png",
                        ),
                        child: IconButton(
                          color: Colors.transparent,
                          iconSize: 200,
                          icon: Icon(Icons.clear),
                          onPressed: _pressedQuestion,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
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
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      radius: 125,
                      backgroundImage: AssetImage("assets/images/notfound.png"),
                      child: IconButton(
                        color: Colors.transparent,
                        iconSize: 200,
                        icon: Icon(Icons.clear),
                        onPressed: _pressedQuestion,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
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
                        onPressed: _pressedAnswer,
                        isSelected: _isSelected),
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
                    onPressed: _pressedBack,
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
                    heroTag: 'btnlike',
                    child: isFavorite
                        ? Icon(
                            Icons.grade,
                            color: Colors.orange,
                            size: 65,
                          )
                        : Icon(
                            Icons.grade_outlined,
                            color: Colors.grey,
                            size: 65,
                          ),
                    onPressed: _pressedFavorite,
                    elevation: 0,
                    backgroundColor: Colors.black.withOpacity(0),
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    heroTag: 'btnforward',
                    onPressed: _pressedForward,
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
