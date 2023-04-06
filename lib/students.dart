import 'package:admin/StudentDetails.dart';
import 'package:admin/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Students extends StatefulWidget {

  const Students({ Key? key }) : super(key: key);

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('students');
  late String _selectedYear;
  @override
  void initState() {
    super.initState();
    _selectedYear = 'ENROLLED'; // set default value for dropdown
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 26, 47),
            title: const Text('Students'),),
            body: Column(
              children: [
                Padding(
            padding: EdgeInsets.only(top: 10,left: 20),
            child: Row(
              children: <Widget>[
                Container(
                    child: Text('Year'),
                ),
                 DropdownButton<String>(
                  value: _selectedYear,
                  items: <String>['ENROLLED', 'NOT ENROLLED']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                      style: TextStyle(
                        color: Colors.amberAccent
                      ),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedYear = newValue!;
                    });
                  },
                  dropdownColor: Colors.grey[800],
                ),
                
              ],
              
            ),
            
            
          ),
          Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: _collectionRef.where('status', isEqualTo: _selectedYear).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          if (documents == null || documents.isEmpty) {
            return Center(child: Text('No data found'));
          }
          return ListView.builder(
            padding: EdgeInsets.only(top: 50),
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
                      builder: (context) => StudentDetails(data: mapData, documentId: docID, ),
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
                      Text(mapData['email'] ?? '',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                      Text(''),
                      Text(mapData['section'] ?? '',
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
      ),)



              ],
            )
       );
  }
}