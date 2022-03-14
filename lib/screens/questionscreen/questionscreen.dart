import 'package:dokumentation_lh/models/tts_settings.dart';
import 'package:dokumentation_lh/utils/allQuestions.dart';
import 'package:dokumentation_lh/utils/user_simple_preferences.dart';
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
  int _counter = 0;
  TtsApi tts = TtsApi();
  TtsSettings ttsSettings = UserSimplePreferences.getTtsSettings();

  /// wird für selbst coded togglebuttons verwendet
  // bool toggle = false;
  bool isFavorite = false;
  bool _firstTimeAns = true;

  List<bool> _firstClick = [true, true, true, true];
  List<bool> _isSelected = [false, false, false, false];

  late List<Question> allQuestions = getAllQuestions();

  @override
  void initState() {
    super.initState();
    ttsSettings = UserSimplePreferences.getTtsSettings();
    tts.initTts(ttsSettings);
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD Function called');
    if (_counter <= allQuestions.length - 1) {
      _title = allQuestions[_counter].category;
      _subtitle = allQuestions[_counter].subcategory;
    }

    void _pressedQuestion() {
      tts.speak(allQuestions[_counter].subcategory);
    }

    /// Triggers when an answer button is pressed
    /// [index] has the number of the 0 of the 3 possibly pressed buttons
    /// checks which button was pressed and if it was the first time
    /// sets the [_firstClick] and [_isSelected] arrays accoring to the pressed button
    /// and checks if the button was pressed the first time
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

    /// triggers if the back button was pressed
    void _pressedBack() {
      if (_counter <= 0) {
        Navigator.pop(context);
      }
      setState(() {
        if (_counter > 0) _counter -= 1;

        // set favorite icon
        isFavorite = allQuestions[_counter].isLiked;

        _isSelected = [false, false, false, false];
        // to select the piktogram which was prior selected
        if (allQuestions[_counter].result != 0) {
          _isSelected[allQuestions[_counter].result - 1] = true;
        }
      });
    }

    /// triggers if the favourise button was pressed
    void _pressedFavorite() {
      isFavorite = !isFavorite;

      if (isFavorite) {
        allQuestions[_counter].isLiked = true;
        tts.speak('ist mir wichtig');
      } else {
        allQuestions[_counter].isLiked = false;
        tts.speak('ist mir nicht wichtig');
      }

      setState(() {});
    }

    /// check if all questions are answerd
    bool _allQuestionAnswerd() {
      bool _allAnswerd = false;
      for (int i = 0; i < allQuestions.length; i++) {
        _allAnswerd = true;
        if (allQuestions[i].result == 0) _allAnswerd = false;
      }
      return _allAnswerd;
    }

    /// find position of not answerd question
    int _findNotAnswerd() {
      for (int i = 0; i < allQuestions.length; i++) {
        if (allQuestions[i].result == 0) return i;
      }
      return 0;
    }

    /// sets the counter, which is the current page
    void _setCounter() {
      if (_counter == allQuestions.length - 1 && _firstTimeAns == true) {
        _firstTimeAns = false;
        _counter = _findNotAnswerd();
      } else if (_counter < allQuestions.length - 1 && _firstTimeAns == true)
        _counter += 1;
      else
        _counter = _findNotAnswerd();
    }

    /// triggers if the forward button was pressed
    void _pressedForward() {
      // if all questions are awnsered go to Result Screen
      if (_allQuestionAnswerd()) {
        Navigator.pushNamed(
          context,
          '/result',
          // hand the result list to the result screen
          arguments: allQuestions,
        );
      } else {
        setState(() {
          // saves the number of the selected piktogram in allQuestions
          allQuestions[_counter].result = _isSelected.indexOf(true) + 1;

          _setCounter();

          // to print results in array
          List<int> resultArr = [];
          allQuestions.forEach((element) {
            resultArr.add(element.result);
          });
          print(resultArr);

          if (_counter < allQuestions.length)
            isFavorite = allQuestions[_counter].isLiked;

          // select no piktogram for the new page
          _isSelected = [false, false, false, false];
          // to select the piktogram which was in front selected
          if (allQuestions[_counter].result != 0) {
            _isSelected[allQuestions[_counter].result - 1] = true;
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
                if (_counter < allQuestions.length)
                  Container(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CircleAvatar(
                        radius: 125,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(20),
                          splashRadius: 135,
                          iconSize: 175,
                          icon: Image.asset(
                            "assets/fragen_img/q_" +
                                (_counter + 1).toString() +
                                ".png",
                          ),
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
                    fit: BoxFit.fill,
                    child: CircleAvatar(
                      radius: 125,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(20),
                        splashRadius: 135,
                        iconSize: 175,
                        icon: Image.asset(
                          "assets/fragen_img_2/q_" +
                              (_counter + 1).toString() +
                              ".png",
                        ),
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
