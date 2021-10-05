import 'dart:io';

import 'package:dokumentation_lh/models/questions.dart';
import 'package:dokumentation_lh/utils/allQuestions.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generate(name, args) async {
    final pdf = Document();

    List questions = getAllQuestions();
    double _imgsize = 45;
    //List<bool> isLiked = args.isLiked;

    List qImages = await _getQImageList();
    List favImages = await _getFavImageList(args);
    List selectedImages = await _getSelectedImageList(args);

    pdf.addPage(MultiPage(
      pageTheme: PageTheme(pageFormat: PdfPageFormat.a4),
      build: (context) => [
        Center(
            child: Text("Ergebnis: ",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ))),
        for (int i = 0; i < 29; i++)
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(
                  width: _imgsize / 2,
                  height: _imgsize / 2,
                  child: Image(MemoryImage(favImages[i]))),
              Container(
                  width: _imgsize,
                  height: _imgsize,
                  child: Image(MemoryImage(qImages[i]))),
            ]),
            Text(questions[i].subcategory),
            Container(
                width: _imgsize,
                height: _imgsize,
                child: Image(MemoryImage(selectedImages[i]))),
          ]),
      ],
    ));

    return saveDocument(name: name, pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  // loads all question images into List, to print in the pdf doc
  static Future _getQImageList() async {
    final List images = [];

    for (int i = 1; i <= 29; i++) {
      final tempImg = (await rootBundle.load(
        "assets/fragen_img/q_" + i.toString() + ".png",
      ))
          .buffer
          .asUint8List();
      images.add(tempImg);
    }

    return images;
  }

  static Future _getFavImageList(List<Question> allQuestions) async {
    final List images = [];

    for (int i = 0; i < 29; i++) {
      if (allQuestions[i].isLiked) {
        final tempImg = (await rootBundle.load(
          "assets/icons/grade.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else {
        final tempImg = (await rootBundle.load(
          "assets/icons/grade_outlined.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      }
    }

    return images;
  }

  static Future _getSelectedImageList(List<Question> allQuestions) async {
    final List images = [];

    for (int i = 0; i < 29; i++) {
      if (allQuestions[i].result == 1) {
        final tempImg = (await rootBundle.load(
          "assets/images/allein_t.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else if (allQuestions[i].result == 2) {
        final tempImg = (await rootBundle.load(
          "assets/images/mit_anleitung_t.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else if (allQuestions[i].result == 3) {
        final tempImg = (await rootBundle.load(
          "assets/images/mit_unterstuetzung_t.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else if (allQuestions[i].result == 4) {
        final tempImg = (await rootBundle.load(
          "assets/images/nicht_t.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else {
        final tempImg = (await rootBundle.load(
          "assets/images/notfound.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      }
    }

    return images;
  }
}
