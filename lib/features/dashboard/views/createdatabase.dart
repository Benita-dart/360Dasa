import 'package:flutter/material.dart';
import 'add_contact_screen.dart';
import '../models/form_model.dart';
import 'package:dasa/features/dashboard/models/database_model.dart';

class CreateDatabaseScreen extends StatefulWidget {
  final Function(DatabaseModel) onSave;

  const CreateDatabaseScreen({Key? key, required this.onSave})
      : super(key: key);

  @override
  _CreateDatabaseScreenState createState() => _CreateDatabaseScreenState();
}

class _CreateDatabaseScreenState extends State<CreateDatabaseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _fields = [];
  List<Map<String, String>> _contacts = [];

  void _addField() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Field Headers'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int index = 0; index < _fields.length; index++)
                  ListTile(
                    title: TextFormField(
                      initialValue: _fields[index],
                      onChanged: (value) {
                        _fields[index] = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Field ${index + 1}',
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          _fields.removeAt(index);
                        });
                      },
                    ),
                  ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _fields.add('');
                    });
                  },
                  child: Text('Add Field'),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _saveFields();
            },
            child: Text('Save Fields'),
          ),
        ],
      ),
    );
  }

  void _saveFields() {
    setState(() {
      // Save fields here
      // For demonstration, we are just printing the fields
      print('Saved fields: $_fields');
    });
  }

  void _navigateToAddContact() {
    DatabaseModel database = DatabaseModel(
      title: _titleController.text,
      description: _descriptionController.text,
      fields: _fields,
    );
    widget.onSave(database);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddContactScreen(
          database: database,
          onContactAdded: (contact) {
            setState(() {
              _contacts.add(contact);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Database'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Fields:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            if (_fields.isEmpty)
              ElevatedButton(
                onPressed: _addField,
                child: Text('Add Field'),
              ),
            if (_fields.isNotEmpty)
              Column(
                children: [
                  DataTable(
                    columns: _fields
                        .map<DataColumn>(
                            (field) => DataColumn(label: Text(field)))
                        .toList(),
                    rows: _contacts.map<DataRow>((contact) {
                      return DataRow(
                        cells: _fields.map<DataCell>((field) {
                          return DataCell(Text(contact[field] ?? ''));
                        }).toList(),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _addField,
                child: Text('Add More Fields'),
              ),
              ElevatedButton(
                onPressed: _navigateToAddContact,
                child: Text('Add Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
