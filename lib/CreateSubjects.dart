import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  void _createSubject() async {
    String subjectName = _subjectNameController.text;
    String grade = _gradeController.text;

    await FirebaseFirestore.instance
        .collection('subjects')
        .add({
          'name': grade+'-'+subjectName, 
          });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Section'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _subjectNameController,
              decoration: InputDecoration(
                labelText: 'Section name',
              ),
            ),
            TextFormField(
              controller: _gradeController,
              decoration: InputDecoration(
                labelText: 'Grade',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createSubject,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
