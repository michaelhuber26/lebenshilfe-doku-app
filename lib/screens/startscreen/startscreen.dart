import 'package:dokumentation_lh/widgets/startscreen_text.dart';
import 'package:dokumentation_lh/models/tts_settings.dart';
import 'package:dokumentation_lh/services/tts_api.dart';
import 'package:dokumentation_lh/utils/user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// introduction screen for the Agogische Dokumentation
class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TtsApi tts = TtsApi();
  TtsSettings ttsSettings = UserSimplePreferences.getTtsSettings();

  @override
  void initState() {
    super.initState();
    ttsSettings = UserSimplePreferences.getTtsSettings();
    tts.initTts(ttsSettings);
    tts.stop();
    tts.speak(text);
    print("STARTSCREEN INIT STATE");
  }

  String text = """Hallo und Willkommen bei der Dokumentation.
Warum braucht es die Dokumentation?
Die Dokumentation ist ein Hilfsmittel.

Es beschreibt die Unterstützung für eine Person.
Es unterstützt Wünsche zu beschreiben.
Es unterstützt bei der Beschreibung: „Was kann die Person machen“.
Es unterstützt bei der Teilhabe. Teilhabe ist, was man gemeinsam mit anderen macht.
Damit kann man besser erkennen, welche Sachen wichtig sind.

Die Dokumentation beschreibt auch welche Hilfen eine Person braucht.
z.B. Hilfe beim Gehen (Rollstuhl oder Rollator)

z.B. Hilfen für den Austausch mit anderen Menschen.

Der Stern beschreibt, ob es besonders wichtig ist.
Wenn du möchtest, kannst du starten.
""";
  bool isSpeaking = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        tts.stop();
        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images_startscreen/Bild1.png",
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      SizedBox(width: 100),
                      startScreenText1,
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images_startscreen/Bild2.png",
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      SizedBox(width: 50),
                      startScreenText2,
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images_startscreen/Bild3.png",
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      SizedBox(width: 51),
                      startScreenText3,
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images_startscreen/Bild4.png",
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      SizedBox(width: 45),
                      startScreenText4,
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images_startscreen/Bild5.png",
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      SizedBox(width: 215),
                      startScreenText5,
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images_startscreen/Bild6.png",
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      SizedBox(width: 180),
                      startScreenText6,
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () {
                          setState(() {
                            tts.stop();
                          });
                          Navigator.pushNamed(context, '/question');
                        },
                        child: Text(
                          'STARTEN',
                          style: TextStyle(fontSize: 45),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
              child: Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 75,
                    width: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.volume_up_rounded,
                        size: 65,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          print("isSpeaking: $isSpeaking");
                          if (isSpeaking) {
                            isSpeaking = false;
                            tts.stop();
                          } else {
                            isSpeaking = true;
                            tts.speak(text);
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 75,
                    width: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 50,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isSpeaking) {
                            isSpeaking = false;
                            tts.stop();
                          }
                        });
                        Navigator.pushNamed(context, '/config');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tts.stop();
    print("dispose STARTSCREEN");
  }
}
