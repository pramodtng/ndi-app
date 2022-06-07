import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ndi_app/admin/screens/list_all_employees.dart';
import 'package:ndi_app/admin/screens/list_all_questions.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Employees(),));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Lottie.network(
                                  'https://assets7.lottiefiles.com/packages/lf20_tjye3eau.json',
                                  height: 120),
                              const Text('Employees'),
                              const SizedBox(
                                height: 5,
                              ),
                              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!.docs.length.toString(),
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    } 
                                    // else if (snapshot.hasError) {
                                    //   return const Center(
                                    //       child: CircularProgressIndicator(),);
                                    // } else {
                                    //   return const CircularProgressIndicator();
                                    // }
                                    else {
                                      return const Text('No Data');
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Lottie.network(
                              'https://assets2.lottiefiles.com/packages/lf20_uCA94X.json',
                              height: 120,
                            ),
                            const Text('Interpersonal'),
                            const SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                future: FirebaseFirestore.instance
                                    .collection('interpersonal')
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.docs.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } 
                                  // else if (snapshot.hasError) {
                                  //   return const Center(
                                  //       child: CircularProgressIndicator(),);
                                  // } else {
                                  //   return const CircularProgressIndicator();
                                  // }
                                  else {
                                      return const Text('No Data');
                                    }
                                }),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Lottie.network(
                              "https://assets6.lottiefiles.com/packages/lf20_khqlojpw.json",
                              height: 120,
                            ),
                            const Text('Personal'),
                            const SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                future: FirebaseFirestore.instance
                                    .collection('personal')
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.docs.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } 
                                  // else if (snapshot.hasError) {
                                  //   return const Center(
                                  //       child: CircularProgressIndicator(),);
                                  // } else {
                                  //   return const CircularProgressIndicator();
                                  // }
                                  else {
                                      return const Text('No Data');
                                    }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
