import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  late String documentId;
  StudentDetails({ Key? key, required this.documentId, required Map<String, dynamic> data,  }) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {

Future<void> deleteDocuments(String documentId) async {

  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('students')
      .doc(widget.documentId)
      .get();

      // Get the email address from the document
      String email = documentSnapshot.get('email');
      String password = documentSnapshot.get('password');

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc('students/$documentId');
  final QuerySnapshot querySnapshot =
      await documentReference.collection('affiliations').get();
  for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
    await snapshot.reference.delete();
  }
  await documentReference.delete();


   // Find the user with the email address and delete them from Firebase Authentication
      User? userToDelete = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email)
          .then((providers) => FirebaseAuth.instance.signInWithCredential(
                EmailAuthProvider.credential(email: email, password: password),
              ).then((userCredential) => userCredential.user));

      if (userToDelete != null) {
        await userToDelete.delete();
      }

}


    Future<void> deleteDocument(String documentId) async {
    // Get the document from Firestore
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('students')
      .doc(widget.documentId)
      .get();

      // Get the email address from the document
      String email = documentSnapshot.get('email');
      String password = documentSnapshot.get('password');


       // Delete the document from Firestore
      await FirebaseFirestore.instance
      .collection('students')
      .doc(widget.documentId)
      .delete();

      
      // Find the user with the email address and delete them from Firebase Authentication
      User? userToDelete = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email)
          .then((providers) => FirebaseAuth.instance.signInWithCredential(
                EmailAuthProvider.credential(email: email, password: password),
              ).then((userCredential) => userCredential.user));

      if (userToDelete != null) {
        await userToDelete.delete();
      }

}
   @override
   Widget build(BuildContext context) {
       
       return Scaffold(
           appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 26, 47),
            title: const Text('Student Details'),),
           body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('students')
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
                  title: Center(
                  child:Text(data['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
                ),), 
                ),
                subtitle: Column(
                  children: <Widget>[
                     SizedBox(height: 10,),
                    Text('Grade', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['grade'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Section', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['section'], style: TextStyle(
                      color: Colors.white
                    ), ),
                   
                    SizedBox(height: 10,),
                    Text('LRN', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['LRN'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Birthay', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['birthday'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Email', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['email'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Address', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['address'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Mother Tongue', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['MT'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Gender', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['gender'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Mothers name', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['mother'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Fathers name', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['father'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Guardian', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['guardian'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Relationship with Guardian', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['relationship'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Religion', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['religion'], style: TextStyle(
                      color: Colors.white
                    ), ),
                  ],
                ),
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
                          deleteDocuments(widget.documentId);
                          
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
                  ),
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
  final _LRNController = TextEditingController();
  final _MTController = TextEditingController();
  final _AddressController = TextEditingController();
  final _BirthdayController = TextEditingController();
  final _EmailController = TextEditingController();
  final _FatherController = TextEditingController();
  final _GenderController = TextEditingController();
  final _GuardianController = TextEditingController();
  final _MotherController = TextEditingController();
   final _RelationshipController = TextEditingController();
    final _ReligionController = TextEditingController();




  late String _initialName;
  late String _initialSubject;
  late String _initialLRN;
  late String _initialMT;
  late String _initialBirthday;
  late String _initialAddress;
  late String _initialEmail;
  late String _initialFather;
  late String _initialGender;
  late String _initialGuardian;
  late String _initialMother;
  late String _initialRelationship;
  late String _initialReligion;

  @override
  void initState() {
    super.initState();
    // Retrieve the current teacher data and populate the text fields
    FirebaseFirestore.instance
        .collection('students')
        .doc(widget.documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        _nameController.text = data['name'];
        _subjectController.text = data['section'];
        _LRNController.text = data ['LRN'];
        _MTController.text = data['MT'];
        _AddressController.text = data['address'];
        _BirthdayController.text = data['birthday'];
        _EmailController .text = data['email'];
        _FatherController.text = data['father'];
        _GenderController.text = data ['gender'];
        _GuardianController.text = data['guardian'];
        _MotherController.text = data['mother'];
        _RelationshipController.text = data ['relationship'];
        _ReligionController.text = data ['religion'];
      




            _initialLRN = data['LRN'];
        _initialMT = data['MT'];
        _initialBirthday = data['birthday'];
      _initialAddress = data['address'];
      _initialEmail = data['email'];
        _initialFather = data['father'];
        _initialGender = data['gender'];
        _initialGuardian = data['guardian'];
      _initialMother = data['mother'];
        _initialRelationship = data['relationship'];
        _initialReligion = data['religion'];


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
        String newLRN = _LRNController.text;
        String newMT = _MTController.text;
        String newAddress = _AddressController.text;
        String newBirthday = _BirthdayController.text;
        String newEmail = _EmailController.text;
        String newFather = _FatherController.text;
        String newGender = _GenderController.text;
        String newGuardian = _GuardianController.text;
        String newMother = _MotherController.text;
        String newRelationship = _RelationshipController.text;
        String newReligion = _ReligionController.text;
        // Only update the fields that have changed
        if (newName != _initialName || newSubject != _initialSubject || newLRN != _initialLRN || newMT != _initialMT || newAddress != _initialAddress ||
        newEmail != _initialEmail || newFather != _initialFather || newGender != _initialGender || newGuardian != _initialGuardian || newMother != _initialMother ||
        newRelationship != _initialRelationship || newReligion != _initialReligion) {
          await FirebaseFirestore.instance
              .collection('students')
              .doc(widget.documentId)
              .update({
            if (newName != _initialName) 'name': newName,
            if (newSubject != _initialSubject) 'section': newSubject,
            if (newLRN != _initialLRN) 'LRN': newLRN,
            if (newMT != _initialMT) 'MT': newMT,
            if (newAddress != _initialAddress) 'address': newAddress,
            if (newEmail != _initialEmail) 'email': newEmail,
            if (newFather != _initialFather) 'father': newFather,
            if (newGender != _initialGender) 'gender': newGender,
            if (newGuardian != _initialGuardian) 'guardian': newGuardian,
            if (newMother != _initialMother) 'mother': newMother,
            if (newRelationship != _initialRelationship) 'relationship': newRelationship,
            if (newReligion != _initialReligion) 'religion': newReligion,
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
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Edit Student'),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
                TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _LRNController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'LRN',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
              
              ),
                TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _MTController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'MT',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                
              ),
                TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _AddressController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Address',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
               
              ),
                TextFormField(
                  enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _BirthdayController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Birthday',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                
              ),
                TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller:_EmailController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
               
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller:_FatherController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Father',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
               
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller:_GenderController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Gender',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller:_GuardianController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Guardian',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller:_MotherController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Mother',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
               
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller:_RelationshipController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Guaridans Relationship',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller:_ReligionController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Religion',
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
                onPressed: (() {
                  _updateTeacher();

                  
                  ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 37, 129, 60), // set the background color
                              content: Text('Successfully Updated'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 
                }) , 
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}