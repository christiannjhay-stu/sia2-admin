
import 'package:admin/Announcement.dart';
import 'package:admin/CreateStudent.dart';
import 'package:admin/CreateSubjects.dart';
import 'package:admin/DeleteSection.dart';
import 'package:admin/Enrollment.dart';
import 'package:admin/GradesLock.dart';
import 'package:admin/NewSchoolYear.dart';
import 'package:admin/TestSection.dart';
import 'package:admin/ViewSection.dart';
import 'package:admin/createAnnouncement.dart';
import 'package:admin/createClub.dart';
import 'package:admin/students.dart';
import 'package:admin/teachers.dart';
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
                          'ADMIN',
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
                            return CreateAnnouncement();
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
                          'Create Announcement',
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
                          'Create Teacher',
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
                            return AddSubjectScreen();
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
                          'Create Section',
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
                            return NextSchoolYear();
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
                          'Start New School Year',
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
           ),

           drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          children: [

            SizedBox(height: 20),
             ListTileTheme(
              child: ListTile(
                
               
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 30),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.home),
                title: const Text('Home'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.work),
                title: const Text('View Teachers'),
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return Teachers();
                    }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('View All Students'),
                  onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return Students();
                    }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
             SizedBox(height: 4),
             ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('View Announcements'),
                  onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return FirestoreDataScreen();
                    }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
             SizedBox(height: 4),
             ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('View By Section'),
                  onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return ViewSection();
                    }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
             SizedBox(height: 4),
             ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('Enrollment'),
                  onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return Enrollment();
                    }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 4),
             ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('Grades Lock'),
                  onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return CheckboxScreen();
                    }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
             SizedBox(height: 4),
             ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('Delete Section'),
                  onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return ViewSubjects();
                    }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 200),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.settings),
                title: const Text('Settings'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.logout),
                title: const Text('Log out'),
                  onTap: () {

                   


                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromARGB(255, 255, 0, 0), // set the background color
                        content: Text('Logged out'), // set the message text
                        duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                      ),
                    );


                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
          ],
        ),
      ),
       );
  }
}
