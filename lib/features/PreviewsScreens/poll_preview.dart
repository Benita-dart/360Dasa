import 'package:flutter/material.dart';
import 'package:dasa/features/dashboard/models/form_model.dart';

class PollPreviewScreen extends StatefulWidget {
  final FormModel poll;

  const PollPreviewScreen({Key? key, required this.poll}) : super(key: key);

  @override
  State<PollPreviewScreen> createState() => _PollPreviewScreenState();
}

class _PollPreviewScreenState extends State<PollPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poll.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.poll.description,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.poll.questions.length,
              itemBuilder: (context, index) {
                final question = widget.poll.questions[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${index + 1}. ${question.question}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      children: question.options.map((option) {
                        final isSelected = question.options.indexOf(option) ==
                            question.selectedOption;

                        return ListTile(
                          title: Text(option),
                          subtitle: LinearProgressIndicator(
                            value: isSelected ? 1.0 : 0.0,
                            valueColor: isSelected
                                ? AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor)
                                : null,
                            backgroundColor: isSelected
                                ? Colors.transparent
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.3),
                          ),
                          onTap: () {
                            // Update the selected option
                            widget.poll.questions[index].selectedOption =
                                question.options.indexOf(option);
                            // Rebuild the UI
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
