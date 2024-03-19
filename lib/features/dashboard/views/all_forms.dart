import 'package:dasa/features/PreviewsScreens/poll_preview.dart';
import 'package:dasa/features/dashboard/views/create_survey.dart';
import 'package:dasa/features/dashboard/views/createdatabase.dart';
import 'package:flutter/material.dart';
import 'create_poll.dart';
import '../models/form_model.dart';
import 'package:dasa/features/PreviewsScreens/SurveyPreview.dart';

class MyForms extends StatefulWidget {
  @override
  State<MyForms> createState() => _MyFormsState();
}

class _MyFormsState extends State<MyForms> {
  int _selectedIndex = 0;
  List<FormModel> _surveys = [];
  List<FormModel> _polls = [];
  List<FormModel> _databases = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<FormModel> selectedList;
    String labelText;
    switch (_selectedIndex) {
      case 0:
        selectedList = _surveys;
        labelText = 'Surveys';
        break;
      case 1:
        selectedList = _polls;
        labelText = 'Polls';
        break;
      case 2:
        selectedList = _databases;
        labelText = 'Databases';
        break;
      default:
        return const Center(
          child: Text('No forms created yet'),
        );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(labelText),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add onPressed action for settings icon
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search $labelText',
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _performSearch('');
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    _performSearch(value);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: selectedList.isEmpty
                ? Center(
                    child: Text('No $labelText created yet'),
                  )
                : ListView.builder(
                    itemCount: selectedList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: _getPrefixIcon(selectedList[index]),
                          title: Text(
                            selectedList[index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(selectedList[index].description),
                              const SizedBox(height: 4),
                              Text(
                                'Created on: ${_formatDateTime(selectedList[index].createdDate)}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {
                              _showOptionsDialog(context, selectedList[index]);
                            },
                          ),
                          onTap: () {
                            _navigateToEditForm(context, selectedList[index]);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateFormDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Surveys',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Polls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Databases',
          ),
        ],
      ),
    );
  }

  Widget _getPrefixIcon(FormModel form) {
    switch (_selectedIndex) {
      case 0:
        return const Icon(Icons.assignment);
      case 1:
        return const Icon(Icons.poll);
      case 2:
        return const Icon(Icons.storage);
      default:
        return const Icon(Icons.assignment);
    }
  }

  void _showCreateFormDialog(BuildContext context) {
    String formName = '';
    String dialogTitle;
    String hintText;

    switch (_selectedIndex) {
      case 0:
        dialogTitle = 'Create a new survey';
        hintText = 'Enter survey name';
        break;
      case 1:
        dialogTitle = 'Create a new poll';
        hintText = 'Enter poll name';
        break;
      case 2:
        dialogTitle = 'Create a new database';
        hintText = 'Enter database name';
        break;
      default:
        dialogTitle = 'Create a new form';
        hintText = 'Enter form name';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            dialogTitle,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          content: TextField(
            onChanged: (value) {
              formName = value;
            },
            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  switch (_selectedIndex) {
                    case 0:
                      _surveys.add(FormModel(
                          name: formName,
                          description: '',
                          questions: [],
                          createdDate: DateTime.now()));
                      break;
                    case 1:
                      _polls.add(FormModel(
                          name: formName,
                          description: '',
                          questions: [],
                          createdDate: DateTime.now()));
                      break;
                    case 2:
                      _databases.add(FormModel(
                          name: formName,
                          description: '',
                          questions: [],
                          createdDate: DateTime.now()));
                      break;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditForm(BuildContext context, FormModel form) async {
    if (_selectedIndex == 0) {
      final updatedForm = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateFormScreen(
            form: form,
            onSave: (updatedForm) {
              setState(() {
                _surveys[_surveys.indexWhere(
                    (element) => element.name == form.name)] = updatedForm;
              });
            },
          ),
        ),
      );

      if (updatedForm != null) {
        // Handle any further actions if needed
      }
    } else if (_selectedIndex == 1) {
      final updatedForm = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePollScreen(
            form: form,
            onSave: (updatedPoll) {
              setState(() {
                _polls[_polls.indexWhere(
                    (element) => element.name == form.name)] = FormModel(
                  name: updatedPoll.name,
                  description: updatedPoll.description,
                  questions: updatedPoll.questions,
                  createdDate: updatedPoll.createdDate,
                );
              });
            },
          ),
        ),
      );

      if (updatedForm != null) {
        // Handle any further actions if needed
      }
    } else if (_selectedIndex == 2) {
      final updatedForm = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateDatabaseScreen(
            onSave: (updatedQuestions) {
              setState(() {
                _databases[_databases
                        .indexWhere((element) => element.name == form.name)] =
                    FormModel(
                        name: form.name,
                        description: form.description,
                        questions: [],
                        createdDate: form.createdDate);
              });
            },
          ),
        ),
      );

      if (updatedForm != null) {
        // Handle any further actions if needed
      }
    }
  }

  void _performSearch(String searchKeyword) {
    // Implement search logic here
    setState(() {
      switch (_selectedIndex) {
        case 0:
          // Filter surveys based on searchKeyword
          break;
        case 1:
          // Filter polls based on searchKeyword
          break;
        case 2:
          // Filter databases based on searchKeyword
          break;
      }
    });
  }

  void _showOptionsDialog(BuildContext context, FormModel form) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.preview),
                title: const Text('Preview'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToPreview(context, form);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                  (context, form);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToEditForm(context, form);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context); // Close the first dialog
                  _showDeleteConfirmationDialog(context, form);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, FormModel form) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this form?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the confirmation dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  switch (_selectedIndex) {
                    case 0:
                      _surveys.remove(form);
                      break;
                    case 1:
                      _polls.remove(form);
                      break;
                    case 2:
                      _databases.remove(form);
                      break;
                  }
                });
                Navigator.pop(context); // Close the confirmation dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPreview(BuildContext context, FormModel form) {
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormPreviewScreen(form: form),
        ),
      );
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PollPreviewScreen(poll: form),
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
