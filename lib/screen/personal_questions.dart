import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ndi_app/getQuestions/get_personal_questions.dart';

class PersonalQuestions extends StatefulWidget {
  const PersonalQuestions({Key? key}) : super(key: key);

  @override
  State<PersonalQuestions> createState() => _PersonalQuestionsState();
}

class _PersonalQuestionsState extends State<PersonalQuestions> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  double rating = 0.0;

  Future getDocID() async {
    // ignore: avoid_function_literals_in_foreach_calls
    await FirebaseFirestore.instance
        .collection('personal')
        .orderBy('questionNo')
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((value) => value.docs.forEach((element) {
              docIDs.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height:5),
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
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GetPersonalNum(documentId: docIDs[index]),
                              ],
                            ),
                            title: GetPersonalQuestions(documentId: docIDs[index]),
                            subtitle: RatingBar.builder(
                              itemSize: 28,
                              updateOnDrag: true,
                              maxRating: 1,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.blue[500],
                                size: 5,
                              ),
                              onRatingUpdate: (rating) => this.rating = rating,
                            ),
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
