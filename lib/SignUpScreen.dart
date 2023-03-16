
import 'package:admin/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

Widget Footer() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 20),
      child: Text(
        textAlign: TextAlign.center,
        'By using Ateneo you agree to our Term of Service and\nPrivacy Policy.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          letterSpacing: 1.2
        ),
      )

  );
}

Widget buildFirstName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          controller: nameController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Name',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildLastName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Lastname',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildSEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Email Address',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildSUsername() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          controller: usernameController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Username',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildSPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.white,

            )
          ),
        )
      )
    ],
  );
}

Widget buildConfirmPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Confirm Password',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}

Widget Logo(){
  return Center(
    child: Image.asset(
      'assets/images/adduLogo.png',
       width: 200,
       height: 200,

      )
  );
}


final emailController = TextEditingController();
final passwordController = TextEditingController();
final nameController = TextEditingController();
final usernameController = TextEditingController();
    

class _SignUpScreenState extends State < SignUpScreen > {

FirebaseFirestore firestore = FirebaseFirestore.instance;

  String email = emailController.text;
  String password = passwordController.text;
 


   void _createStudent() async {
    
    final CollectionReference _myCollection = firestore.collection('students');

    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    String username = usernameController.text;

    Map<String, dynamic> data = {
        
        "name": name,
        "username": username,
        "email": email,
        "password": password
      };
            try {
        // Add data to the main collection
        await _myCollection.add({'data': data});

        // Get a reference to the newly added document
        QuerySnapshot querySnapshot = await _myCollection.get();
        DocumentSnapshot documentSnapshot = querySnapshot.docs.last;
        String documentId = documentSnapshot.id;

        // Add a subcollection named 'affiliations' to the newly added document
        CollectionReference affiliationsRef = _myCollection
            .doc(documentId)
            .collection('affiliations');

        // Add data to the subcollection
        await affiliationsRef.add({'clubs': name});

        print('Data added successfully');
      } catch (e) {
        print('Error adding data: $e');
      }
       
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title:Text('Create Student'),
      ),
      body: AnnotatedRegion < SystemUiOverlayStyle > (
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: < Widget > [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: < Widget > [
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                        child: Text(
                          'Ateneo de Davao\nUniversity\nCreate Student',
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
                    Logo(),
                    SizedBox(height: 20),
                    buildFirstName(),
                    buildSUsername(),
                    buildSEmail(),
                    buildSPassword(),
                    SizedBox(height: 12),
                    Container(
                      width: 340,
                      height: 60,
                      child: TextButton(
                        onPressed: () {
                          _createStudent();
                          
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text.trim(), 
                            password: passwordController.text.trim()
                            
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 27, 100, 25), // set the background color
                              content: Text('Account Successfully Created'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 

                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return HomeScreen();
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll < Color > (Color(0xffFBB718)),
                          shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            )
                          )
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Noopla"
                          ),

                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       
                      ],
                    ),
                    Footer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
