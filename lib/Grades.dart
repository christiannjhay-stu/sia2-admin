import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  final String studentId;
  
  
  const MyHomePage({Key? key, required this.studentId}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _selectedYear;
  
  @override
  void initState() {
    super.initState();
    _selectedYear = '2023'; // set default value for dropdown
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> subjectsRef =
        FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('Subjects')
            .where('Year', isEqualTo: _selectedYear);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Grades'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10,left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5),
                    child: Text('Year',
                    style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
                SizedBox(width: 5,),
                 DropdownButton<String>(
                  value: _selectedYear,
                  items: <String>['2023', '2024', '2025', '2026', '2027', '2028', '2029']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                      style: TextStyle(
                        color: Colors.amberAccent
                      ),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedYear = newValue!;
                    });
                  },
                  dropdownColor: Colors.grey,
                ),
                SizedBox(width: 37,),
                Container(
                  child: Text('1ST', style: TextStyle(color: Colors.white),),
                ),
                   SizedBox(width: 37,),
                Container(
                  child: Text('2ND',style: TextStyle(color: Colors.white)),
                ),
                 SizedBox(width: 37,),
                Container(
                  child: Text('3RD',style: TextStyle(color: Colors.white)),
                ),
                 SizedBox(width: 37,),
                    Container(
                  child: Text('4TH', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 37,),
                Container(
                  child: Text('FINAL',style: TextStyle(color: Colors.white)),
                ),
                
                
              ],
              
              
            ),
            
            
            
          ),
          
          
          
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: subjectsRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Text('No subjects found for this student.');
                }
              
                

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Map<String, dynamic>> subjectDoc =
                        snapshot.data!.docs[index];

                    return Card(
                      shape: Border.all(width: 1),
                      color: Color.fromARGB(255, 36, 59, 78),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                             
                              child: Text(
                              subjectDoc['name'],
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            ),
                            
                            SizedBox(height: 10),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: subjectDoc.reference
                                  .collection('Grades')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                      gradesSnapshot) {
                                if (gradesSnapshot.hasError) {
                                  return Text('Error: ${gradesSnapshot.error}');
                                }

                                if (gradesSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading...');
                                }

                                if (gradesSnapshot.data == null ||
                                    gradesSnapshot.data!.docs.isEmpty) {
                                  return Text('No grades found for this subject.');
                                }

                          List<String> gradesList = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade1'] as String,
                                  )
                              .toList();

                               List<String> gradesList1 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade2'] as String,
                                  )
                              .toList();
                                List<String> gradesList2 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade3'] as String,
                                  )
                              .toList();
                                List<String> gradesList3 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade4'] as String,
                                  )
                              .toList();
                               List<String> gradesList4 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Final'] as String,
                                  )
                              .toList();

                          
                          return Row(
                            
                            crossAxisAlignment: CrossAxisAlignment.center,
                            
                            children: [
                              SizedBox(width: 13,),
                             Container(
                                
                                padding: EdgeInsets.only(left: 30),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                                  SizedBox(width: 25,),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList1.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                                 SizedBox(width: 30,),
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList2.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                                SizedBox(width: 25,),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList3.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                               SizedBox(width: 32,),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList4.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 218, 185, 0), fontWeight: FontWeight.bold),
                                ),
                              ),
                                ],)
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                    
                  ),
                  
                ),
              );
            },
          );
        },
      ),
          )]
    ));
  }
}