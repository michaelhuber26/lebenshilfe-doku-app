import 'package:dokumentation_lh/screens/configscreen/configscreen.dart';
import 'package:dokumentation_lh/screens/loginscreen/loginscreen.dart';
import 'package:dokumentation_lh/screens/questionscreen/questionscreen.dart';
import 'package:dokumentation_lh/screens/resultscreen/resultscreen.dart';
import 'package:dokumentation_lh/screens/startscreen/startscreen.dart';
import 'package:dokumentation_lh/theme/style.dart';
import 'package:dokumentation_lh/utils/user_simple_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      darkTheme: appTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/question': (context) => QuestionScreen(),
        '/start': (context) => StartScreen(),
        '/result': (context) => ResultScreen(),
        '/config': (context) => ConfigScreen()
      },
    );
  }
}
