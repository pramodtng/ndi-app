import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../crud_personal/add_question.dart';
import '../crud_personal/update_questions.dart';

class ListPersonalQuestions extends StatefulWidget {
  const ListPersonalQuestions({Key? key}) : super(key: key);

  @override
  _ListPersonalQuestionsState createState() => _ListPersonalQuestionsState();
}

class _ListPersonalQuestionsState extends State<ListPersonalQuestions> {
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
      .collection('personal')
      .orderBy('questionNo')
      .snapshots();

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('personal');
  Future<void> deleteUser(id) {
    // print("Question Deleted $id");
    return students
        .doc(id)
        .delete()
        // ignore: avoid_print
        .then((value) => print('Question Deleted'))
        // ignore: avoid_print
        .catchError((error) => print('Failed to Delete the Question: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddPersonalQuestions()));
                    },
                    child: const Text('Add New Question')),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(4),
                      2: FlexColumnWidth(2),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: const Center(
                                child: Text(
                                  'ID',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: const Center(
                                child: Text(
                                  'Question',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: const Center(
                                child: Text(
                                  'Action',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var i = 0; i < storedocs.length; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text(
                                      storedocs[i]['questionNo'] ?? 'No data',
                                      style: const TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text(
                                      storedocs[i]['question'] ?? 'No Data',
                                      style: const TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePersonalQuestions(
                                                  id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
