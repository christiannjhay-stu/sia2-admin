import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> _subjects = [];
  String? _selectedSubject;

  @override
  void initState() {
    super.initState();
    _getSubjects();
  }

  void _getSubjects() async {
    final snapshot = await firestore.collection('subjects').get();
    final List<String> subjects = [];
  
    snapshot.docs.forEach((doc) {
      final subject = doc.get('name');
      final grade = doc.get('grade');
      subjects.add(subject);
    
    });
    setState(() {
      _subjects = subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subjects Dropdown')),
      body: Center(
        child: DropdownButtonFormField<String>(
          value: _selectedSubject,
          items: _subjects.map((subject) {
            return DropdownMenuItem<String>(
              value: subject,
              child: Text(subject),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedSubject = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Assign Section',
          ),
        ),
      ),
    );
  }
}
