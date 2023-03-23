
import 'package:admin/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
    

    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    String username = usernameController.text;
    
    
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('students');

    DocumentReference newUserRef = usersCollection.doc();

    String newUserId = newUserRef.id;

    newUserRef.set({
      "name": name,
        "username": username,
        "email": email,
        "password": password
    });
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title:Text('Create Student'),
      ),
      body: ListView (
        children: <Widget>[
          GestureDetector(
          child: Stack(
            children: < Widget > [
              
              Expanded(
                child: Container(
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
                    Center(
                    child: Image.asset(
                      'assets/images/adduLogo.png',
                      width: 200,
                      height: 200,
                        )
                    ),              
                    SizedBox(height: 20),
                    buildFirstName(),
                    buildSUsername(),
                    buildSEmail(),
                    buildSPassword(),
                    SizedBox(height: 12),
                  
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
              )
              
            ],
          ),
        ),
        ],
        
      ),
    );
  }
}
