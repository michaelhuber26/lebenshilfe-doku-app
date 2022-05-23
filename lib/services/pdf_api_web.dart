import 'package:dokumentation_lh/models/questions.dart';
import 'package:dokumentation_lh/utils/allQuestions.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class PdfApiWeb {
  static Future generate(args) async {
    final pdf = pw.Document();
    List questions = getAllQuestions();
    double _imgsize = 45;
    //List<bool> isLiked = args.isLiked;
    List qImages = await _getQImageList();
    print("load qImages...");
    List favImages = await _getFavImageList(args);
    print("load favImages...");
    List selectedImages = await _getSelectedImageList(args);
    print("load selectedImages...");

    pdf.addPage(pw.MultiPage(
      pageTheme: pw.PageTheme(pageFormat: PdfPageFormat.a4),
      build: (context) => [
        pw.Center(
            child: pw.Text("Ergebnis: ",
                style: pw.TextStyle(
                  decoration: pw.TextDecoration.underline,
                  fontWeight: pw.FontWeight.bold,
                ))),
        for (int i = 0; i < 28; i++)
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(children: [
                  pw.Container(
                      width: _imgsize / 2,
                      height: _imgsize / 2,
                      child: pw.Image(pw.MemoryImage(favImages[i]))),
                  pw.Container(
                      width: _imgsize,
                      height: _imgsize,
                      child: pw.Image(pw.MemoryImage(qImages[i]))),
                ]),
                pw.Text(questions[i].subcategory),
                pw.Container(
                    width: _imgsize,
                    height: _imgsize,
                    child: pw.Image(pw.MemoryImage(selectedImages[i]))),
              ]),
      ],
    ));
    print("saving pdf");
    final bytes = await pdf.save();
    print("creating pdf blob");
    final blob = html.Blob([bytes], 'application/pdf');

    print("PDF created!!");
    return html.Url.createObjectUrlFromBlob(blob);
  }

  static download(url) async {
    print("downloading PDF...");
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'ergebnis.pdf';
    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  static openWindow(url) async {
    print("opening PDF...");
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  }

  // loads all question images into List, to print in the pdf doc
  static Future _getQImageList() async {
    final List images = [];

    for (int i = 1; i <= 28; i++) {
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

    for (int i = 0; i < 28; i++) {
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

    for (int i = 0; i < 28; i++) {
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
