

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  late String documentId;

  Details({ Key? key,required this.documentId, required Map<String, dynamic> data }) : super(key: key);
  
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Future<void> deleteDocument(String documentId) async {
  await FirebaseFirestore.instance
      .collection('teachers')
      .doc(widget.documentId)
      .delete();
}
   @override
   Widget build(BuildContext context) {
       
       return Scaffold(
           appBar: AppBar(title: const Text('Teacher Details'),),
           body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('teachers')
            .doc(widget.documentId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No data found.'),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return Card(
            color: Color.fromARGB(255, 9, 26, 47).withOpacity(0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(data['name'],
                  style: TextStyle(color: Colors.white),),
                  subtitle: Text(data['email'],style: TextStyle(color: Colors.white),),
                ),
                new IconButton(
                        icon: Icon(Icons.edit,
                        color: Color.fromARGB(255, 255, 251, 0),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            
                            return EditTeacherScreen(documentId: widget.documentId);
                          }));
                          
 
                        },
                      ),

                Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(Icons.delete, color: Color.fromARGB(255, 255, 0, 0),),
                        onPressed: () {
                          // Replace 'documentId' with the ID of the current document
                          deleteDocument(widget.documentId);
                          
                          Navigator.pop(context);
                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 189, 27, 27), // set the background color
                              content: Text('Successfully Deleted'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 
                        },
                      );
                    },
                  )
               
                
              ],
            ),
          );
        },
           )
       );
  }
}



class EditTeacherScreen extends StatefulWidget {
  final String documentId;

  EditTeacherScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _EditTeacherScreenState createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  late String _initialName;
  late String _initialSubject;

  @override
  void initState() {
    super.initState();
    // Retrieve the current teacher data and populate the text fields
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(widget.documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        _nameController.text = data['name'];
        _subjectController.text = data['section'];
        _initialName = data['name'];
        _initialSubject = data['section'];
      }
    });
  }

  Future<void> _updateTeacher() async {
    if (_formKey.currentState!.validate()) {
      try {
        String newName = _nameController.text;
        String newSubject = _subjectController.text;
        // Only update the fields that have changed
        if (newName != _initialName || newSubject != _initialSubject) {
          await FirebaseFirestore.instance
              .collection('teachers')
              .doc(widget.documentId)
              .update({
            if (newName != _initialName) 'name': newName,
            if (newSubject != _initialSubject) 'section': newSubject,
          });
        }
        Navigator.pop(context); // Navigate back to the previous screen
      } catch (e) {
        print('Error updating teacher: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Teacher'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _nameController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _subjectController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Section',
                ),
               
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateTeacher,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}