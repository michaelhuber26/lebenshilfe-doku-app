import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/questions.dart';

class PdfApi {
  static Future<File> generate(name, args) async {
    final pdf = Document();
    Question q = Question(category: '', subcategory: '');
    List questions = q.getAllQuestions();
    double _imgsize = 45;
    //List<bool> isLiked = args.isLiked;

    List qImages = await _getQImageList();
    List favImages = await _getFavImageList(args.isLiked);
    List selectedImages = await _getSelectedImageList(args.result);

    pdf.addPage(MultiPage(
      pageTheme: PageTheme(pageFormat: PdfPageFormat.a4),
      build: (context) => [
        Center(child: Text("Ergebnis: ")),
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

  static Future _getFavImageList(List<bool> isLiked) async {
    final List images = [];

    for (int i = 0; i < 29; i++) {
      if (isLiked[i]) {
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

  static Future _getSelectedImageList(List<int> result) async {
    final List images = [];

    for (int i = 0; i < 29; i++) {
      if (result[i] == 1) {
        final tempImg = (await rootBundle.load(
          "assets/images/allein_t.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else if (result[i] == 2) {
        final tempImg = (await rootBundle.load(
          "assets/images/mit_anleitung_t.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else if (result[i] == 3) {
        final tempImg = (await rootBundle.load(
          "assets/images/mit_unterstuetzung_t.png",
        ))
            .buffer
            .asUint8List();
        images.add(tempImg);
      } else if (result[i] == 4) {
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