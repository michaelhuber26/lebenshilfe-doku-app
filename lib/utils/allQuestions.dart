import 'package:dokumentation_lh/models/all_categories.dart';
import 'package:dokumentation_lh/models/questions.dart';

// create List with Question Objects and fill with questions from all_categories obj
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
