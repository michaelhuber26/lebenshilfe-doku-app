import 'package:dokumentation_lh/models/questions.dart';
import 'package:flutter/material.dart';

class ListViewResult extends StatelessWidget {
  ListViewResult({
    Key? key,
    required this.args,
  }) : super(key: key);

  final double _imgsize = 110;
  final List<Question> args;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: args.length,
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
                          args[index].subcategory + ": ",
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
