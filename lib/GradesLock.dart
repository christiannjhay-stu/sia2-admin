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
  late bool _data5 = false;
    late bool _data6 = false;
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
      _data5 = data['data5'];
      _data6 = data['data6'];
    });
  }

  Future<void> _updateData() async {
    await _firestore.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').update({
      'data1': _data1,
      'data2': _data2,
      'data3': _data3,
      'data4': _data4,
      'data5': _data5,
      'data6': _data6,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Grades Lock'),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: Text('1ST QUARTER',style: TextStyle(color: Color.fromARGB(246, 255, 208, 0)),),
            value: _data1,
            activeColor: Color.fromARGB(246, 255, 208, 0),
            onChanged: (value) {
              setState(() {
                _data1 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('2ND QUARTER',style: TextStyle(color: Color.fromARGB(246, 255, 208, 0)),),
            value: _data2,
            activeColor: Color.fromARGB(246, 255, 208, 0),
            onChanged: (value) {
              setState(() {
                _data2 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('3RD QUARTER',
            style: TextStyle(color: Color.fromARGB(246, 255, 208, 0)),),
            value: _data3,
            activeColor: Color.fromARGB(246, 255, 208, 0),
            onChanged: (value) {
              setState(() {
                _data3 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('4TH QUARTER',style: TextStyle(color: Color.fromARGB(246, 255, 208, 0)),),
            value: _data4,
            activeColor: Color.fromARGB(246, 255, 208, 0),
            onChanged: (value) {
              setState(() {
                _data4 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('FINAL GRADE',style: TextStyle(color: Color.fromARGB(246, 255, 208, 0)),),
            value: _data5,
            activeColor: Color.fromARGB(246, 255, 208, 0),
            onChanged: (value) {
              setState(() {
                _data5 = value!;
                _updateData();
              });
            },
          ),
          CheckboxListTile(
            title: Text('FINAL REMAKRS',style: TextStyle(color: Color.fromARGB(246, 255, 208, 0)),),
            value: _data6,
            activeColor: Color.fromARGB(246, 255, 208, 0),
            onChanged: (value) {
              setState(() {
                _data6 = value!;
                _updateData();
              });
            },
          ),
        ],
      ),
    );
  }
}
