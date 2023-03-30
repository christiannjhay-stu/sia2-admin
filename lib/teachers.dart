import 'package:admin/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Teachers extends StatefulWidget {

  const Teachers({ Key? key }) : super(key: key);

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('teachers');

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Teachers'),),
            body: StreamBuilder<QuerySnapshot>(
        stream: _collectionRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          if (documents == null || documents.isEmpty) {
            return Center(child: Text('No data found'));
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final data = documents[index].data();
              final docID = documents[index].id;
              if (data == null) {
                return SizedBox();
              }
              final mapData = data as Map<String, dynamic>;

              Stack(

              );
              return GestureDetector(
                onTap: () {
                  print(docID);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details( data: mapData, documentId: docID, ),
                    ),
                  );
                },
                child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                borderOnForeground: true,
                
                color: Color.fromARGB(255, 9, 26, 47).withOpacity(0.2),
                  child: ListTile(
                  leading: CircleAvatar(
                  radius: 30,
                 
                ),
                  title: Text(mapData['name'] ?? '',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      Text(mapData['section'] ?? '',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                      Text(''),
                      Text(mapData['email'] ?? '',
                  style: TextStyle(
                    color: Color.fromARGB(246, 255, 208, 0)
                  ),),
                      
                    ],
                  ) 
                ),
                )
              );
              
            },
          );
        },
      ),
       );
  }
}