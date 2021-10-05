import 'package:dokumentation_lh/models/questions.dart';

List<Question> getAllQuestions() {
  List<Question> questions = [];

  all_categories.forEach((element) {
    element['subcategory'].forEach((subelement) {
      questions.add((Question(
          category: element['category'],
          subcategory: subelement['subcategory'])));
    });
  });

  return questions;
}
