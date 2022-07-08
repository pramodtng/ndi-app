// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndi_app/auth/loginScreen.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ndi_app/modal/user_modal.dart';
import 'package:ndi_app/screen/interpersonal_questions.dart';
import 'package:ndi_app/screen/personal_questions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModal loggedInUser = UserModal();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModal.fromMap(value.data());
      setState(() {});
    });
  }
  int index = 0;
  final screens = [
    const InterPersonalQuestions(),
    const PersonalQuestions(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
        ),
        title: Text("Welcome, ${loggedInUser.username}👋", style: GoogleFonts.pacifico(
          fontSize:22
        )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white38,
            ),
            onPressed: () {
              logout(context);
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: screens[index],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600,
            )
          ),
        ),
        child: NavigationBar(
          height: 80,
          backgroundColor: Colors.grey.shade300,
          selectedIndex: index,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (index) => 
            setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.interpreter_mode_rounded),
              icon: Icon(Icons.interpreter_mode_outlined),
              label:'Interpersonal',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label:'Personal',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
