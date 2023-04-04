

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetailScreen extends StatelessWidget {
  
  final Map < String, dynamic > data;
  
  final String doCID;
  
  

  DetailScreen({
    required this.data,
    required this.doCID
  });



  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('clubs');

  void deleteDocument(String documentId) {
    _collectionReference.doc(documentId).delete().then((value) {
      print('Document deleted successfully!');
    }).catchError((error) {
      print('Failed to delete document: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text(data['name']),
      ),
      body: Container(
        child: Center(
          child: Stack(
          children: < Widget > [
            Column(
              children: [
                Padding(padding: EdgeInsets.all(20),
                  
                ),
                Padding(padding: EdgeInsets.all(20),
                  child: Text(data['description'], style: TextStyle(

                    fontSize: 20,
                    color: Colors.white
                  ),)
                ),
                SizedBox(height: 20),
                Container(
                      width: 340,
                      height: 60,
                      child: TextButton(
                        onPressed: () async {
                          deleteDocument(doCID);

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 196, 44, 6), // set the background color
                              content: Text('Successfully Deleted'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 


                        Navigator.pop(context);

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
                          'Delete',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Noopla"
                          ),

                        ),
                      ),
                )
              ],
            )
          ],
        ),
        )
        
        
        
      )
    );
  }
}