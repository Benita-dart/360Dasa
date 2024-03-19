class FormModel {
  final String name;
  String description;
  List<QuestionEntry> questions;
  DateTime createdDate;

  FormModel({
    required this.name,
    this.description = '',
    required this.questions,
    required this.createdDate,
  });
}

class QuestionEntry {
  String question = '';
  String answerType = 'Short Text'; // Default answer type
  List<String> options;
  int? selectedOption;

  QuestionEntry(
      {this.question = '',
      this.answerType = 'Short Text',
      required this.options});
}
