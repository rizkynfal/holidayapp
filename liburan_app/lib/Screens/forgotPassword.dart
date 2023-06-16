// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liburan_app/Screens/signInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  var databaseUsers = FirebaseFirestore.instance.collection('users');
  var userCredential = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();

  void clearValue() {
    _emailController.clear();
  }

  String? passwordBaru;
  Future<void> forgotPassword(String email) async {
    String? id;

    databaseUsers.where('email', isEqualTo: email).snapshots().listen((event) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(actions: [
                Column(
                  children: [
                    const Text(
                      "Password Baru : ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextField(
                      onChanged: (value) {
                        passwordBaru = value;
                      },
                      decoration:
                          const InputDecoration(hintText: ' Password Baru'),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Center(
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () async {
                                await userCredential.signInWithEmailAndPassword(
                                    email: event.docs[0]['email'].toString(),
                                    password:
                                        event.docs[0]['password'].toString());
                                try {
                                  await userCredential.currentUser!
                                      .updatePassword(passwordBaru!);
                                  AuthCredential credential =
                                      EmailAuthProvider.credential(
                                          email: email,
                                          password: passwordBaru!);
                                  await userCredential.currentUser!
                                      .reauthenticateWithCredential(credential);
                                  id = userCredential.currentUser!.uid;
                                  await databaseUsers
                                      .doc(id)
                                      .update({'password': passwordBaru});
                                  await userCredential.signOut().then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(color: Colors.green),
                              )),
                          TextButton(
                              onPressed: () {
                                setState(() {});
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Batal',
                                style: TextStyle(color: Colors.red),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  const Text("Masukkan Email Anda"),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _emailController),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      await forgotPassword(_emailController.text);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return Colors.blue;
                      }),
                    ),
                    child: const Text("Reset Password"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return Colors.red;
                      }),
                    ),
                    child: const Text("Back"),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
