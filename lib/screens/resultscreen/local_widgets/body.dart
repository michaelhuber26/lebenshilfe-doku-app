import 'package:dokumentation_lh/services/pdf_api.dart';
import 'package:dokumentation_lh/models/questions.dart';
import 'package:dokumentation_lh/utils/allQuestions.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.args,
  }) : super(key: key);

  final List<Question> args;

  @override
  Widget build(BuildContext context) {
    return Center(
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
              ElevatedButton(
                onPressed: () async {
                  final pdfFile = await PdfApi.generate("ergebnis.pdf", args);
                  PdfApi.openFile(pdfFile);
                },
                child: Text(
                  'PDF öffnen',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ListViewResult extends StatelessWidget {
  ListViewResult({
    Key? key,
    required this.args,
  }) : super(key: key);

  final List questions = getAllQuestions();
  final double _imgsize = 110;
  final List<Question> args;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (args[index].isLiked)
                      Icon(
                        Icons.grade,
                        color: Colors.orange,
                        size: 65,
                      ),
                    if (args[index].isLiked == false)
                      Icon(
                        Icons.grade_outlined,
                        color: Colors.grey,
                        size: 65,
                      ),
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
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    if (args[index].result == 0)
                      Image.asset(
                        "assets/images/notfound.png",
                        width: _imgsize,
                        height: _imgsize,
                      ),
                    if (args[index].result == 1)
                      Image.asset(
                        "assets/images/allein_t.png",
                        width: _imgsize,
                        height: _imgsize,
                      ),
                    if (args[index].result == 2)
                      Image.asset(
                        "assets/images/mit_anleitung_t.png",
                        width: _imgsize,
                        height: _imgsize,
                      ),
                    if (args[index].result == 3)
                      Image.asset(
                        "assets/images/mit_unterstuetzung_t.png",
                        width: _imgsize,
                        height: _imgsize,
                      ),
                    if (args[index].result == 4)
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
    );
  }
}
