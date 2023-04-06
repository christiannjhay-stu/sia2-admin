import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NextSchoolYear extends StatefulWidget {
  @override
  _NextSchoolYearState createState() => _NextSchoolYearState();
}



class _NextSchoolYearState extends State<NextSchoolYear> {


    final YearController = TextEditingController();
    final SchoolYearController = TextEditingController();
  
void addDocumentsToSubjectsAndGrades() {
  FirebaseFirestore.instance.collection('students').get().then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {

      String Year = YearController.text;
      String Sy = SchoolYearController.text;
      


      final CollectionReference collectionRef = FirebaseFirestore.instance.collection('schoolyear');
              collectionRef.doc('SchoolYear').update({
          'yearStarted': Year,
          'schoolyear':Sy
        });


      // Add documents to 'Subjects' subcollection
      FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'MAPEH',
            'Year': Year,
          });
            FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'SCIENCE',
            'Year': Year,
          });
            FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'ESP',
            'Year': Year
          });
           FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'ENGLISH',
            'Year': Year
          });
           FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'TLE',
            'Year': Year
          });
           FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'MTB',
            'Year': Year
          });
           FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'AP',
            'Year': Year
          });
           FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'MATH',
            'Year': Year
          });
           FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .add({
            'name': 'FILIPINO',
            'Year': Year
          });
      
      // Add documents to 'Grades' collection in each subject
      FirebaseFirestore.instance
          .collection('students')
          .doc(doc.id)
          .collection('Subjects')
          .get()
          .then((querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              FirebaseFirestore.instance
                  .collection('students')
                  .doc(doc.reference.parent.parent?.id)
                  .collection('Subjects')
                  .doc(doc.id)
                  .collection('Grades')
                  .add({
                    'Grade1': '',
                    'Grade2': '',
                    'Grade3': '',
                    'Grade4': '',
                    'Year': Year
                  });
            });
          });
    });
  });
}



  String _inputText1 = '';
  String _inputText2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next School Year'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: SchoolYearController,
              onChanged: (value) {
                setState(() {
                  _inputText1 = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'School Year',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: YearController,
              style: TextStyle(
                color: Colors.white
              ),
              onChanged: (value) {
                setState(() {
                  _inputText2 = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Year Started',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                  addDocumentsToSubjectsAndGrades();
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
