// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ndi_app/admin/interpersonal_Questions/add_questions_page.dart';
import 'package:ndi_app/admin/interpersonal_Questions/list_questions_page.dart';
import 'package:ndi_app/admin/personal_Questions/add_personal_questions.dart';
import 'package:ndi_app/admin/personal_Questions/list_personal_questions.dart';
import 'package:ndi_app/auth/loginScreen.dart';

class AdminDashBoard extends StatelessWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  Widget _buildContainer(
      {required IconData icon,
      required int count,
      required String name,
      required BuildContext context}) {
    return Card(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Text(name,
                      style: const TextStyle(
                        fontSize: 20,
                      ))
                ],
              ),
              const SizedBox(height: 10),
              Align(
                  alignment: Alignment.center,
                  child: Text(count.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ))),
            ],
          )),
    );
  }

  Future<List<DocumentSnapshot<Object?>>> getEmployee() async {
    QuerySnapshot count =
        await FirebaseFirestore.instance.collection('users').get();
    List<DocumentSnapshot> totalCount = count.docs;
    // ignore: avoid_print
    return totalCount;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: TabBar(
              labelColor: Colors.redAccent,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  color: Colors.white),
              indicatorColor: Colors.black,
              indicatorWeight: 2,
              tabs: [
                Text('DashBoard',
                    style: TextStyle(
                      fontSize: 17,
                    )),
                Text('Interpersonal',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                Text('Personal',
                    style: TextStyle(
                      fontSize: 17,
                    )),
              ],
            ),
          ),
          leadingWidth: 0,
          automaticallyImplyLeading: false,
          title: const Text('Welcome, Admin',
              style: TextStyle(color: Colors.blue)),
          // backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const LoginScreen())));
              },
            )
          ],
        ),
        body: TabBarView(children: [
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  _buildContainer(
                    icon: Icons.person,
                    count: 14,
                    name: 'Employee',
                    context: context,
                  ),
                  _buildContainer(
                    icon: Icons.person,
                    count: 40,
                    name: 'Interpersonal',
                    context: context,
                  ),
                  _buildContainer(
                    icon: Icons.person,
                    count: 25,
                    name: 'Personal',
                    context: context,
                  ),
                ],
              )),
          // ignore: avoid_unnecessary_containers
          Column(
            children: [
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.topCenter,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddQuestions()));
                  },
                  child: const Text('Add Questions',
                      style: TextStyle(fontSize: 16)),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 1,
                ),
              ),
              //  const SizedBox(height: 2),
              const ListQuestions(),
            ],
          ),
          // ignore: avoid_unnecessary_containers
          Column(
            children: [
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.topCenter,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddPersonalQuestions()));
                  },
                  child: const Text('Add Questions',
                      style: TextStyle(fontSize: 16)),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 1,
                ),
              ),
              const SizedBox(height: 2),
              const ListPersonalQuestions(),
            ],
          ),
        ]),
      ),
    );
  }
}
