// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liburan_app/Screens/signInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  CollectionReference databaseUsers =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  final TextEditingController _biodataController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _profesiController = TextEditingController();
  void clearValue() {
    _emailController.clear();
    _passwordController.clear();
    _tglLahirController.clear();
    _namaController.clear();
    _biodataController.clear();
  }

  Future<void> insertData(String email, String password, String nama,
      String biodata, String profesi, String tglLahir) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await databaseUsers.doc(userCredential.user!.uid.toString()).set({
        'email': email,
        'password': password,
        'nama': nama,
        'biodata': biodata,
        'profesi': profesi,
        'tanggal lahir': tglLahir,
        'favorit_place': []
      });
      clearValue();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Sign Up Berhasil !'),
          content: const Text("Silahkan Melakukan Login"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  )),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Password Terlalu Lemah !'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Email Telah Terdaftar !'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Gagal Melakukan Sign Up, Cek Internet Anda !'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
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
                  const Text("Email"),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _emailController),
                  const SizedBox(height: 50),
                  const Text("Password"),
                  TextFormField(controller: _passwordController),
                  const SizedBox(height: 50),
                  const Text("Nama"),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _namaController),
                  const SizedBox(height: 50),
                  const Text("Biodata"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: _biodataController,
                  ),
                  const SizedBox(height: 50),
                  const Text("Profesi"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: _profesiController,
                  ),
                  const SizedBox(height: 50),
                  const Text("Tanggal Lahir"),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _tglLahirController),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      insertData(
                          _emailController.text,
                          _passwordController.text,
                          _namaController.text,
                          _biodataController.text,
                          _profesiController.text,
                          _tglLahirController.text);
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
                    child: const Text("Daftar"),
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
