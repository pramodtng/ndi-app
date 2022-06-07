import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiplayEmployeeList extends StatefulWidget {
  const DiplayEmployeeList({Key? key}) : super(key: key);

  @override
  State<DiplayEmployeeList> createState() => _DiplayEmployeeListState();
}

class _DiplayEmployeeListState extends State<DiplayEmployeeList> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocID() async {
    // ignore: avoid_function_literals_in_foreach_calls
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((value) => value.docs.forEach((element) {
              docIDs.add(element.reference.id);
            }));
  }

  @override
  void initState() {
    getDocID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Hello'),
        ],
      ),
    ));
  }
}
