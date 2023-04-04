
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  late String documentId;

  Details({ Key? key,required this.documentId, required Map<String, dynamic> data }) : super(key: key);
  
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Future<void> deleteDocument(String documentId) async {
    // Get the document from Firestore
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('teachers')
      .doc(widget.documentId)
      .get();

      // Get the email address from the document
      String email = documentSnapshot.get('email');
      String password = documentSnapshot.get('password');


       // Delete the document from Firestore
      await FirebaseFirestore.instance
      .collection('teachers')
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
                  title: Center(
                  child: Text(data['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
                ),), 
                ),
                  subtitle: Column(
                    children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Email', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['email'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Grade Level', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['grade'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Section', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['section'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Address', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['address'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                    Text('Contact Number', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['contact'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Gender', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['gender'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Birthday', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['birthday'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Mother Tongue', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['MT'], style: TextStyle(
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

  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _emailController = TextEditingController();
  final _GradeController = TextEditingController();
  final _addressController = TextEditingController();
   final _contactController = TextEditingController();
   final _genderController = TextEditingController();
    final _BirthdayController = TextEditingController();
    final _MTController = TextEditingController();
        final _ReligionController = TextEditingController();

  late String _initialAddress;
  late String _initialName;
  late String _initialSubject;
  late String _initialEmail;
   late String _initialGrade;
  late String _initialContact;
   late String _initialGender;
    late String _initialBirthday;
    late String _initialMT;
  late String _initialReligion;


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
        _emailController.text = data['email'];
        _GradeController.text = data['grade'];
        _addressController.text = data['address'];
     _contactController.text = data['contact'];
      _genderController.text = data['gender'];
      _BirthdayController.text = data['birthday'];
       _MTController.text = data['MT'];
        _ReligionController.text = data['religion'];

       _initialName = data['name'];
        _initialSubject = data['section'];
        _initialGrade = data['grade'];
         _initialAddress = data['address'];
          _initialContact = data['contact'];
             _initialGender = data['gender'];
             _initialBirthday = data['birthday'];
               _initialMT = data['MT'];
        _initialReligion = data ['religion'];
       
        
      }
    });
  }

  
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null && picked != _selectedDate) {
    setState(() {
      _selectedDate = picked;
      DateTime truncatedDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        0,
        0,
        0,
        0,
        0,
      );
      String formattedDateString =
          DateFormat('dd/MM/yyyy').format(truncatedDate);
      _BirthdayController.text = formattedDateString;
    });
  }
}

  Future<void> _updateTeacher() async {
    if (_formKey.currentState!.validate()) {
      try {
        String newName = _nameController.text;
        String newSubject = _subjectController.text;
        String newGrade = _GradeController.text;
        String newAddress = _addressController.text;
        String newContact = _contactController.text;
        String newGender = _genderController.text;
        String newBirthday = _BirthdayController.text;
        String newMT = _MTController.text;
        String newReligion = _ReligionController.text;
        // Only update the fields that have changed
        if (newName != _initialName || newSubject != _initialSubject || newGrade != _initialGrade || newAddress != _initialAddress
        || newContact != _initialContact || newGender != _initialGender  || newBirthday != _initialBirthday || newMT != _initialMT || newReligion != _initialReligion) {
          await FirebaseFirestore.instance
              .collection('teachers')
              .doc(widget.documentId)
              .update({
            if (newName != _initialName) 'name': newName,
            if (newSubject != _initialSubject) 'section': newSubject,
            if (newGrade != _initialGrade) 'grade': newGrade,
            if (newAddress != _initialAddress) 'address': newAddress,
            if (newContact != _initialContact) 'contact': newContact,
            if (newGender != _initialGender) 'gender': newGender,
            if (newBirthday != _initialBirthday) 'birthday': newBirthday,
            if (newMT != _initialMT) 'MT': newMT,
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
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _emailController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Email',
                ),
                
              ),
               TextFormField(
                
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _GradeController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Grade Level',
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
              TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _addressController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Address',
                ),
               
              ),
               TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _contactController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Contact Number',
                ),
    
              ),
              TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _genderController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Gender',
                ),
                
              ),
              TextFormField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                  controller: _BirthdayController,
                  decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'DD/MM/YYYY',
                ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  keyboardType: TextInputType.datetime,
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
                ),
               
              ),
               TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _ReligionController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Religion',
                ),
               
              ),
              SizedBox(height: 16.0),
               ElevatedButton(
                onPressed: () {
                  _updateTeacher();
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color.fromARGB(255, 23, 133, 60), // set the background color
                    content: Text('Successfully Updated'), // set the message text
                    duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                  ),
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}