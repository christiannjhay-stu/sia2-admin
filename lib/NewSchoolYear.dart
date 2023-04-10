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
    querySnapshot.docs.forEach((doc) async {

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
          //ADD 1 TO THE GRADE
          final CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');

          // Get all the documents in the collection
          final QuerySnapshot snapshot = await studentsCollection.get();

          // Loop through each document and update the age field
          snapshot.docs.forEach((doc) async {
            final int age = int.parse(doc['grade']);
            final int newAge = age + 1;
            final String newAgeString = newAge.toString();

            await studentsCollection.doc(doc.id).update({'grade': newAgeString});
          });


          //UNENROLL
          CollectionReference studentsRef = FirebaseFirestore.instance.collection('students');

          // Update all documents in the collection
          studentsRef.get().then((querySnapshot) {
            querySnapshot.docs.forEach((document) {
              document.reference.update({
                'status': 'Not Enrolled',
                'section': ''
                
                });
            });
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
                    'Final': '',
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
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Next School Year'),
      ),
      body: Center(
        
        child: Column(
          
         
          children: [
            Container(
            padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Antonio Pichon Jr.\nElementary School\nNew School Year',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ateneo",
                ),
              ),

          ),
          SizedBox(height: 25),
          Center(
            child: Image.asset(
              'assets/images/adduLogo.png',
              width: 200,
              height: 200,
            )
          ),
          SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
              controller: SchoolYearController,
              onChanged: (value) {
                setState(() {
                  _inputText1 = value;
                });
              },
             decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'School Year',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
            ),
            ),
            
            SizedBox(height: 16.0),
            Container(
               alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
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
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Year Started',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
            ),
                  
            ),
            
            SizedBox(height: 16.0),
            Container(
              height: 60,
              width: 340,
              
              child: ElevatedButton(
              
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(246, 255, 208, 0)),
                shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    )
                  )
              ),
              onPressed: () {
                  addDocumentsToSubjectsAndGrades();
              },
              
              child: Text('Start', style: TextStyle( fontSize: 16),),
            ),
            )
            
          ],
        ),
      ),
    );
  }
}
