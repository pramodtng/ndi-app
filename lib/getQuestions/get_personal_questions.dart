import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetPersonalQuestions extends StatelessWidget {
  final String documentId;
  
  GetPersonalQuestions({ Key? key, required this.documentId }) : super(key: key);
  
  CollectionReference questions = FirebaseFirestore.instance.collection('personal');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: questions.doc(documentId).get(),
      builder: ((context, snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['question']}');
        }
        return const Text('Questions Loading');
      }),
    );
  }
}

CollectionReference questions = FirebaseFirestore.instance.collection('personal');

class GetPersonalNum extends StatelessWidget {
  final String documentId;
  const GetPersonalNum({ Key? key,required this.documentId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<DocumentSnapshot>(
      future: questions.doc(documentId).get(),
      builder: ((context, snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['questionNo']}', style: const TextStyle(
            fontSize: 16,
          ),);
        }
        return const Text('ID');
      }),
    );
  }
}