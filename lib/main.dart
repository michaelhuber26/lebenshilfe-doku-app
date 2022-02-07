import 'package:dokumentation_lh/screens/configscreen/configscreen.dart';
import 'package:dokumentation_lh/theme/style.dart';
import 'package:dokumentation_lh/utils/user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'screens/questionscreen/questionscreen.dart';
import 'screens/loginscreen/loginscreen.dart';
import 'screens/resultscreen/resultscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      darkTheme: appTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/question': (context) => QuestionScreen(),
        '/result': (context) => ResultScreen(),
        '/config': (context) => ConfigScreen()
      },
    );
  }
}
