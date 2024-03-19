import 'package:flutter/material.dart';
import '../models/form_model.dart';

class CreateFormScreen extends StatefulWidget {
  final FormModel form;
  final Function(FormModel) onSave;

  const CreateFormScreen({Key? key, required this.form, required this.onSave})
      : super(key: key);

  @override
  _CreateFormScreenState createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.form.name),
        actions: [
          IconButton(
            onPressed: () {
              // Implement share functionality
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              // Implement save functionality
              widget.onSave(widget.form); // Pass back the updated form
              Navigator.pop(context); // Go back to previous screen after saving
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to Questions screen
                      },
                      child: const Text('Questions'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to Responses screen
                      },
                      child: const Text('Responses'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Survey Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.form.description,
                onChanged: (value) {
                  setState(() {
                    widget.form.description = value;
                  });
                },
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Enter survey description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.form.questions.length,
                itemBuilder: (context, index) {
                  return QuestionEntryWidget(
                    question: widget.form.questions[index],
                    onDelete: () {
                      setState(() {
                        widget.form.questions.removeAt(index);
                      });
                    },
                    onAnswerTypeChanged: (type) {
                      setState(() {
                        widget.form.questions[index].answerType = type!;
                        if (type == 'Multiple Choice' || type == 'Check Box') {
                          // Reset options for other types
                          widget.form.questions[index].options = [];
                        }
                      });
                    },
                    onOptionChanged: (option, optionIndex) {
                      setState(() {
                        widget.form.questions[index].options[optionIndex] =
                            option;
                      });
                    },
                    onAddOption: () {
                      setState(() {
                        widget.form.questions[index].options.add('');
                      });
                    },
                    onDeleteOption: (optionIndex) {
                      setState(() {
                        widget.form.questions[index].options
                            .removeAt(optionIndex);
                      });
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.form.questions.add(QuestionEntry(options: ['']));
                    });
                  },
                  child: const Text('Add New Question'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionEntryModel {
  String question = '';
  String answerType = 'Short Text'; // Default answer type
  List<String> options;

  QuestionEntryModel(
      {this.question = '',
      this.answerType = 'Short Text',
      required this.options});
}

class QuestionEntryWidget extends StatelessWidget {
  final QuestionEntry question;
  final VoidCallback onDelete;
  final Function(String?) onAnswerTypeChanged;
  final Function(String, int) onOptionChanged;
  final VoidCallback onAddOption;
  final Function(int) onDeleteOption;

  const QuestionEntryWidget({
    required this.question,
    required this.onDelete,
    required this.onAnswerTypeChanged,
    required this.onOptionChanged,
    required this.onAddOption,
    required this.onDeleteOption,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: question.question,
              onChanged: (value) {
                question.question = value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter question',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: question.answerType,
              onChanged: (value) {
                onAnswerTypeChanged(value);
              },
              items: <String>[
                'Short Text',
                'Long Text',
                'Multiple Choice',
                'Range',
                'Check Box',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            if (question.answerType == 'Multiple Choice' ||
                question.answerType == 'Check Box')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ...question.options.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String option = entry.value;
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: option,
                            onChanged: (value) {
                              onOptionChanged(value, index);
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter option',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            onDeleteOption(index);
                          },
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete Option',
                        ),
                      ],
                    );
                  }).toList(),
                  TextButton.icon(
                    onPressed: onAddOption,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Option'),
                  ),
                ],
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
