import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetEmployeeList extends StatelessWidget {

  final String documentId;

  GetEmployeeList({Key? key, required this.documentId}) : super(key: key);

  CollectionReference questions = FirebaseFirestore.instance.collection('interpersonal');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: questions.doc(documentId).get(),
      builder: ((context, snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          // ignore: prefer_adjacent_string_concatenation
          return Text('${data['name']}');
        }
        return const Text('Names Loading');
      }),
    );
  }
}