import 'package:flutter/material.dart';
import '../models/form_model.dart';

class CreatePollScreen extends StatefulWidget {
  final FormModel form; // Existing form data
  final Function(FormModel) onSave;

  const CreatePollScreen({
    Key? key,
    required this.form,
    required this.onSave,
  }) : super(key: key);

  @override
  _CreatePollScreenState createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  List<QuestionEntry> _questions = [];

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.form.description;
    _questions.addAll(widget.form.questions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.form.name), // Set the app bar title to form name
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addQuestion();
              },
              child: const Text('Add Poll Question'),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return _buildQuestionCard(index);
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _savePoll();
              },
              child: const Text('Save Poll'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = _questions[index];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: TextEditingController(text: question.question),
              onChanged: (value) {
                _questions[index].question = value;
              },
              decoration: const InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _addOption(index);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Option'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: question.options.length,
              itemBuilder: (context, optionIndex) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(
                            text: question.options[optionIndex]),
                        onChanged: (value) {
                          _questions[index].options[optionIndex] = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Option ${optionIndex + 1}',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          _questions[index].options.removeAt(optionIndex);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addQuestion() {
    setState(() {
      _questions.add(QuestionEntry(question: '', options: []));
    });
  }

  void _addOption(int questionIndex) {
    setState(() {
      _questions[questionIndex].options.add('');
    });
  }

  void _savePoll() {
    final title = widget.form.name;
    final description = _descriptionController.text;
    final poll = FormModel(
      name: title,
      description: description,
      questions: _questions,
      createdDate: widget.form.createdDate,
    );

    // Pass the updated poll back to the previous screen
    widget.onSave(poll);

    // Close the current screen
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
