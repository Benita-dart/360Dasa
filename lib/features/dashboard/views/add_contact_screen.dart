import 'package:flutter/material.dart';
import '../models/form_model.dart';
import 'package:dasa/features/dashboard/models/database_model.dart';

class AddContactScreen extends StatefulWidget {
  final DatabaseModel database;
  final Function(Map<String, String>) onContactAdded; // Added this line

  const AddContactScreen(
      {Key? key, required this.database, required this.onContactAdded})
      : super(key: key);

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  late List<String> _contactData;

  @override
  void initState() {
    super.initState();
    _contactData = List.filled(widget.database.fields.length, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Contact Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.database.fields.length,
              itemBuilder: (context, index) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: widget.database.fields[index],
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _contactData[index] = value;
                  },
                );
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                _saveContact();
              },
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    Map<String, String> contact = {};
    for (int i = 0; i < widget.database.fields.length; i++) {
      contact[widget.database.fields[i]] = _contactData[i];
    }
    widget.onContactAdded(contact);
    Navigator.pop(context); // Go back to the CreateDatabaseScreen
  }
}
