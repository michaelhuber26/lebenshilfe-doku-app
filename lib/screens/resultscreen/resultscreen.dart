import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/questions.dart';
import 'local_widgets/body.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:dokumentation_lh/services/pdf_api.dart';
import 'package:dokumentation_lh/models/questions.dart';
import 'package:dokumentation_lh/services/pdf_api_web.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late List<Question> args;
  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  bool _isLoading = false;

  void _startLoading() async {
    if (isAndroid || isIOS) {
      final pdfFile = await PdfApi.generate("ergebnis.pdf", args);
      PdfApi.openFile(pdfFile);
    } else if (isWeb) {
      print("creating PDF...");

      setState(() {
        _isLoading = true;
      });
      _isLoading = true;
      final pdfFile = await PdfApiWeb.generate(args);

      PdfApiWeb.openWindow(pdfFile);
      setState(() {
        _isLoading = false;
      }); // PdfApiWeb.download(pdfFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as List<Question>;

    return Scaffold(
        appBar: AppBar(
          title: Text("ResultScreen"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Übersicht über die ausgewählten Piktogramme',
                style: TextStyle(fontSize: 40),
              ),
              ListViewResult(args: args),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text(
                      'GO BACK TO LOGIN',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: _isLoading
                        ? CircularProgressIndicator()
                        : Icon(Icons.add),
                    onPressed: _isLoading ? null : _startLoading,
                    label: Text(
                      'PDF öffnen',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  // if (_isLoading) CircularProgressIndicator()
                ],
              )
            ],
          ),
        ));
  }
}
