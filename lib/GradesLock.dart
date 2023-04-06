import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckboxScreen extends StatefulWidget {
  @override
  _CheckboxScreenState createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<CheckboxScreen> {
  late bool _data1 = false;
  late bool _data2 = false;
  late bool _data3 = false;
  late bool _data4 = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').get();
    final Map<String, dynamic> data = snapshot.data()!;
    setState(() {
      _data1 = data['data1'];
      _data2 = data['data2'];
      _data3 = data['data3'];
      _data4 = data['data4'];
    });
  }

  Future<void> _updateData() async {
    await _firestore.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').update({
      'data1': _data1,
      'data2': _data2,
      'data3': _data3,
      'data4': _data4,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grades Lock'),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: Text('1ST QUARTER',style: TextStyle(color: Colors.white),),
            value: _data1,
            onChanged: (value) {
              setState(() {
                _data1 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('2ND QUARTER',style: TextStyle(color: Colors.white),),
            value: _data2,
            onChanged: (value) {
              setState(() {
                _data2 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('3RD QUARTER',
            style: TextStyle(color: Colors.white),),
            value: _data3,
            onChanged: (value) {
              setState(() {
                _data3 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('4TH QUARTER',style: TextStyle(color: Colors.white),),
            value: _data4,
            onChanged: (value) {
              setState(() {
                _data4 = value!;
                _updateData();
              });
            },
          ),
        ],
      ),
    );
  }
}
