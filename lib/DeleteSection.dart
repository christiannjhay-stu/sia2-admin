import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewSubjects extends StatefulWidget {
  @override
  _ViewSubjectsState createState() => _ViewSubjectsState();
}

class _ViewSubjectsState extends State<ViewSubjects> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('subjects');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Subjects'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add functionality
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _collectionRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(child: Text('No data found'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final data = documents[index].data();
              final docID = documents[index].id;
              if (data == null) {
                return SizedBox();
              }
              final mapData = data as Map<String, dynamic>;

              return Card(
                color: Color.fromARGB(255, 87, 151, 230).withOpacity(0.2),
                elevation: 4.0,
                margin: EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  title: Text(mapData['name'] ?? '', style: TextStyle(color: Colors.white),),
                  
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red,),
                    onPressed: () async {
                      await _collectionRef.doc(docID).delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
