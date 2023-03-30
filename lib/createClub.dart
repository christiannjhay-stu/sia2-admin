import 'package:admin/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateClub extends StatefulWidget {

  const CreateClub({
    Key ? key
  }): super(key: key);

  @override
  State < CreateClub > createState() => _CreateClubState();
}



class _CreateClubState extends State < CreateClub > {


    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final usernameController = TextEditingController();



  void _createStudent () async {

    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    String username = usernameController.text;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('teachers');

    DocumentReference newUserRef = usersCollection.doc();

    String newUserId = newUserRef.id;

    newUserRef.set({
        "name": name,
        "description": username,
        "email": email,
        "password":password,
        "section": ''
    });

  }
      
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: const Text('Create Club'), ),
      body: ListView(
        children: < Widget > [
          Container(
            padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Ateneo de Davao\nUniversity\nCreate Club',
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
          Center(
            child: Column(
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
            ),
          ),
          Center(
            child: Column(
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
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                  )
                )
              ],
            ),
          ),
          Center(
            child: Column(
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
            )
          ),
          Center(
            child: Column(
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
                    keyboardType: TextInputType.text,
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
            ),
          ),
          SizedBox(height: 12, ),
          Center(
            child: Container(
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
                      content: Text('Teacher Successfully Created'), // set the message text
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
                  'Create Club',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Noopla"
                  ),

                ),
              ),
            ),
          ),
          Center(
            child: Container(
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

            ),
          )

        ],
      ),
    );
  }
}