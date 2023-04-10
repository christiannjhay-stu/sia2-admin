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
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Create Section'),
      ),
      body: Center(
       
        child: Padding(padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Container(
            padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Antonio Pichon Jr.\nElementary School\nCreate Section',
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
              child: TextFormField(
              style: TextStyle(
                color: Colors.white
              ),
              controller: _subjectNameController,
               decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Section Name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
            ),
              
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
              child: TextFormField(
              style: TextStyle(
                color: Colors.white
              ),
              controller: _gradeController,
             decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Grade',
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
              child:  ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(246, 255, 208, 0)),
                shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    )
                  )
              ),
              onPressed: _createSubject,
              child: Text('Create', style: TextStyle(
                fontSize: 16
              ),),
            ),
            )
              ],
            ),
        )

      ),
    );
  }
}
