import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ndi_app/admin/dashboard_admin.dart';


class AddPersonalQuestions extends StatefulWidget {
  const AddPersonalQuestions({Key? key}) : super(key: key);

  @override
  State<AddPersonalQuestions> createState() =>
      _AddPersonalQuestionsState();
}

class _AddPersonalQuestionsState extends State<AddPersonalQuestions> {
  final _formKey = GlobalKey<FormState>();
  var questionNo = '';
  var question = '';
  var comment = '';
  final questionNoEditingController = TextEditingController();
  final questionEditingController = TextEditingController();
  final commentEditingController = TextEditingController();
  CollectionReference questions =
      FirebaseFirestore.instance.collection('personal');

  // ignore: non_constant_identifier_names
  Future<void> AddPersonalQuestions() {
    return questions
        .add({
          'questionNo': questionNo,
          'question': question,
          'comment': comment
        })
        // ignore: avoid_print
        .then((value) => print('Question Added'))
        // ignore: avoid_print
        .catchError((error) => print('Failed to Add question: $error'));
  }

  clearText() {
    questionNoEditingController.clear();
    questionEditingController.clear();
    commentEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final questionNoField = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      controller: questionNoEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Question No is required");
        }
        return null;
      },
      onSaved: (value) {
        questionNoEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.numbers_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Question No',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );

    final questionField = TextFormField(
      autofocus: false,
      controller: questionEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Question is required");
        }
        return null;
      },
      onSaved: (value) {
        questionEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.question_mark),
          contentPadding: const EdgeInsets.fromLTRB(20, 45, 10, 15),
          hintText: 'Question',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );

    final commentField = TextFormField(
      autofocus: false,
      controller: commentEditingController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        commentEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.comment_bank),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Any Comment',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Question"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashBoard()));
          }
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 150,
                              child: Lottie.network(
                                'https://assets4.lottiefiles.com/packages/lf20_iyjr5y3a.json',
                                fit: BoxFit.contain,
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Add new question',
                                style: GoogleFonts.playfairDisplay(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red)),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          questionNoField,
                          const SizedBox(height: 15),
                          questionField,
                          const SizedBox(height: 15),
                          commentField,
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      questionNo =
                                          questionNoEditingController.text;
                                      question = questionEditingController.text;
                                      comment = commentEditingController.text;
                                      AddPersonalQuestions();
                                      Fluttertoast.showToast(
                                          msg: "Question added successful",
                                          backgroundColor: Colors.redAccent);
                                      clearText();
                                    });
                                  }
                                },
                                child: const Text(
                                  'Add',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  clearText();
                                },
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                              ),
                            ],
                          )
                        ],
                      )),
                ))),
      ),
    );
  }
}
