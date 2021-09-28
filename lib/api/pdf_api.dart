import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../questions.dart';

class PdfApi {
  static Future<File> generate(name, args) async {
    final pdf = Document();
    Question q = Question(category: '', subcategory: '');
    List questions = q.getAllQuestions();
    double _imgsize = 110;

    final image1 = (await rootBundle.load('assets/images/allein_t.png'))
        .buffer
        .asUint8List();

    pdf.addPage(MultiPage(
      pageTheme: PageTheme(pageFormat: PdfPageFormat.a4),
      build: (context) => [
        Text("text"),
        Container(width: 100, height: 100, child: Image(MemoryImage(image1))),
        Container(width: 100, height: 100, child: Image(MemoryImage(image1))),
        Container(width: 100, height: 100, child: Image(MemoryImage(image1))),
        Container(width: 100, height: 100, child: Image(MemoryImage(image1))),
        Container(width: 100, height: 100, child: Image(MemoryImage(image1))),
        Container(width: 100, height: 100, child: Image(MemoryImage(image1))),
        Container(width: 100, height: 100, child: Image(MemoryImage(image1))),
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
}
