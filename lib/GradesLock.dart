import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckboxScreen extends StatefulWidget {
  @override
  _CheckboxScreenState createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<CheckboxScreen> {
  late bool _data1 = false;

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
    });
  }

  Future<void> _updateData() async {
    await _firestore.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').update({
      'data1': _data1,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grades Lock'),
      ),
      body: CheckboxListTile(
        title: Text('Data 1'),
        value: _data1,
        onChanged: (value) {
          setState(() {
            _data1 = value!;
            _updateData();
          });
        },
      ),
    );
  }
}
