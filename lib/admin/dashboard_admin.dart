import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndi_app/admin/screens/dashboard.dart';
import 'package:ndi_app/admin/screens/list_all_questions.dart';
import 'package:ndi_app/admin/screens/screen3.dart';
import 'package:ndi_app/auth/loginScreen.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({ Key? key }) : super(key: key);

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  int index = 0;
  final screens = [
    const DashBoard(),
    const ListQuestions(),
    const ListPersonalQuestions(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
        ),
        title: Text("Welcome, Admin👋", style: GoogleFonts.pacifico(
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
              selectedIcon: Icon(Icons.dashboard),
              icon: Icon(Icons.dashboard_outlined),
              label:'DashBoard',
            ),
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