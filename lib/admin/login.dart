import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndi_app/admin/dashboard_admin.dart';
import 'package:ndi_app/auth/loginScreen.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController adminemainController = TextEditingController();
  final TextEditingController adminpasswordController = TextEditingController();


  
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: adminemainController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email address");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please enter a valid email address");
        }
        return null;
      },
      onSaved: (value) {
        adminemainController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: adminpasswordController,
      validator: (value) {
        // ignore: unnecessary_new
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid password");
        }
        return null;
      },
      onSaved: (value) {
        adminpasswordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );

    //lOGIN BUTTON
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn();
          },
          child: const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
    return Scaffold(
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
                              height: 200,
                              child: Image.asset(
                                'assets/logo.jpg',
                                fit: BoxFit.contain,
                              )),
                          emailField,
                          const SizedBox(height: 10),
                          passwordField,
                          const SizedBox(height: 10),
                          loginButton,
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Login as '),
                              GestureDetector(
                                  onTap: () {
                                     Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                  child: const Text('User',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)))
                            ],
                          ),
                        ],
                      )),
                ))),
      ),
    );
  }

  signIn() {
   FirebaseFirestore.instance.collection('admin').get().then((value) {
    // ignore: avoid_function_literals_in_foreach_calls
    value.docs.forEach((element) {
      if(element.data()['adminemail'] != adminemainController.text.trim() ) {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your email is not accurate')));
        Fluttertoast.showToast(msg: 'Email is incorrect');
      }
      else if(element.data()['adminpassword'] != adminpasswordController.text.trim() ) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your password is not accurate')));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Successful')));

        setState(() {
          adminemainController.text = "";
          adminpasswordController.text = "";
        });
        Route route = MaterialPageRoute(builder: (context) => const AdminDashBoard());
        Navigator.pushReplacement(context, route);
      }
    });
   });
  }
}
