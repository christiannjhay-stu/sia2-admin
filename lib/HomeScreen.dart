import 'package:admin/SignUpScreen.dart';
import 'package:admin/createClub.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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

class _HomeScreenState extends State<HomeScreen> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
            backgroundColor: Color.fromARGB(255, 9, 26, 47),
           appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 26, 47),
            title: const Text('Admin'),),
           body: Center(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                        child: Text(
                          'Ateneo de Davao\nUniversity',
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
                    SizedBox(height: 100),
                    Container(
                      width: 340,
                      height: 60,
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return SignUpScreen();
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll < Color > (Color.fromARGB(255, 251, 183, 24)),
                          shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            )
                          )
                        ),
                        child: Text(
                          'Create Student',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Noopla"
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 340,
                      height: 60,
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextButton(
                        onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return CreateClub();
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll < Color > (Color.fromARGB(255, 251, 183, 24)),
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
                  ],
                )
              ],
            ),
           )
       );
  }
}
