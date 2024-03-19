import 'package:dasa/common/widgets/colors.dart';
import 'package:flutter/material.dart';
import '../dashboard/models/form_model.dart';

class FormPreviewScreen extends StatelessWidget {
  final FormModel form;

  const FormPreviewScreen({Key? key, required this.form}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Card(
                  shadowColor: AppColors.primaryColor,
                  elevation: 10,
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          form.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          form.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ignore: prefer_const_constructors
              Text(
                'Questions:',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: form.questions.length,
                itemBuilder: (context, index) {
                  final question = form.questions[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${question.question}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          if (question.answerType == 'Short Text')
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your answer',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          if (question.answerType == 'Multiple Choice')
                            Column(
                              children: question.options.map((option) {
                                return RadioListTile(
                                  title: Text(option),
                                  value:
                                      '', // Empty value to satisfy required parameter
                                  groupValue:
                                      null, // TODO: Implement handling of selected value
                                  onChanged: (value) {
                                    // TODO: Implement handling of radio button selection
                                  },
                                );
                              }).toList(),
                            ),
                          if (question.answerType == 'Check Box')
                            Column(
                              children: question.options.map((option) {
                                return CheckboxListTile(
                                  title: Text(option),
                                  value: false,
                                  onChanged: (value) {
                                    // TODO: Implement handling of checkbox selection
                                  },
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
