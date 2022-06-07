import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Employees extends StatefulWidget {
  const Employees({ Key? key }) : super(key: key);

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Employees'),
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: FutureBuilder(
                future: getDocID(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            minLeadingWidth: 10,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            title: ListAllEmployees(documentId: docIDs[index]),
                            tileColor: Colors.grey[400],
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class ListAllEmployees extends StatelessWidget {
   ListAllEmployees({ Key? key,required this.documentId }) : super(key: key);
  
  final String documentId;

  CollectionReference questions = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: questions.doc(documentId).get(),
      builder: ((context, snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['username']}');
        }
        return const Text('');
      }),
    );
  }
}