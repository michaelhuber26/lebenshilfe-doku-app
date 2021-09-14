import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './questions.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    Question q = Question(category: '', subcategory: '');
    List questions = q.getAllQuestions();
    double _imgsize = 110;

    final args = ModalRoute.of(context)!.settings.arguments as Question;

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
            Column(
              children: [
                Text(
                  'Ausgewählte Piktogramme der Reihenfolge nach:' +
                      args.result.toString() +
                      '\n',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Image.asset(
                                // "assets/fragen_img/q_1.png",
                                "assets/fragen_img/q_" +
                                    (index + 1).toString() +
                                    ".png",
                                width: _imgsize,
                                height: _imgsize,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                height: 25,
                                child: Text(
                                  questions[index].subcategory + ": ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            if (args.result[index] == 0)
                              Image.asset(
                                "assets/images/notfound.png",
                                width: _imgsize,
                                height: _imgsize,
                              ),
                            if (args.result[index] == 1)
                              Image.asset(
                                "assets/images/allein_t.png",
                                width: _imgsize,
                                height: _imgsize,
                              ),
                            if (args.result[index] == 2)
                              Image.asset(
                                "assets/images/mit_anleitung_t.png",
                                width: _imgsize,
                                height: _imgsize,
                              ),
                            if (args.result[index] == 3)
                              Image.asset(
                                "assets/images/mit_unterstuetzung_t.png",
                                width: _imgsize,
                                height: _imgsize,
                              ),
                            if (args.result[index] == 4)
                              Image.asset(
                                "assets/images/nicht_t.png",
                                width: _imgsize,
                                height: _imgsize,
                              ),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    );
                  }),
            ),
            // for (var i in args) Text(i.toString()),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'GO BACK TO LOGIN',
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
