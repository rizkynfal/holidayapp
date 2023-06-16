// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liburan_app/HomePage.dart';
import 'package:liburan_app/Screens/signInScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPref extends StatefulWidget {
  const MyPref({Key? key}) : super(key: key);
  @override
  State<MyPref> createState() => _MyPrefPageState();
}

class _MyPrefPageState extends State<MyPref> {
  final double coverHeight = 200;
  final double profileHeight = 120;
  var userCredential = FirebaseAuth.instance;
  var userData = FirebaseFirestore.instance.collection('users');
  Map<String, dynamic>? snapshots;
  String? email;
  String? password;
  Future<void> getDataUser() async {
    final docId = FirebaseAuth.instance.currentUser!.uid.toString();
    final data = await userData.doc(docId).get();
    setState(() {
      snapshots = data.data()!;
    });
  }

  @override
  void initState() {
    setState(() {
      snapshots;
      getDataUser();
    });
    super.initState();
  }

  Future<bool> updatePassword(String id, String pass) async {
    userData.doc(id).update({'password': pass});
    final data = await userData.doc(id).get();
    final newData = data.data()!;
    late bool alrdyUpdt;
    try {
      await userCredential.currentUser!.updatePassword(pass);

      AuthCredential credential = EmailAuthProvider.credential(
          email: newData['email'].toString(), password: pass);
      await userCredential.currentUser!
          .reauthenticateWithCredential(credential);
      setState(() {
        snapshots = data.data()!;
        alrdyUpdt = true;
      });
      return alrdyUpdt;
    } catch (err) {
      setState(() {
        alrdyUpdt = false;
      });
    }
    return alrdyUpdt;
  }

  Future<bool> updateEmail(String id, String email) async {
    userData.doc(id).update({'email': email});
    final data = await userData.doc(id).get();
    final newData = data.data()!;
    late bool alrdyUpdt;
    try {
      await userCredential.currentUser!.updateEmail(email);

      AuthCredential credential = EmailAuthProvider.credential(
          email: email, password: newData['password'].toString());
      await userCredential.currentUser!
          .reauthenticateWithCredential(credential);
      setState(() {
        snapshots = data.data()!;
        alrdyUpdt = true;
      });
      return alrdyUpdt;
    } catch (err) {
      setState(() {
        alrdyUpdt = false;
      });
    }
    return alrdyUpdt;
  }

  Future<void> updateNama(String id, String nama) async {
    return userData
        .doc(id)
        .update({'nama': nama})
        .then((value) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(actions: [
                Column(
                  children: [
                    const Text(
                      'Data Berhasil DiUpdate',
                      style: TextStyle(color: Colors.green),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OKE',
                            style: TextStyle(color: Colors.blue),
                          )),
                    )
                  ],
                ),
              ]),
            ))
        .catchError((error) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(actions: [
                Column(
                  children: [
                    const Text(
                      'Error Menghapus Data',
                      style: TextStyle(color: Colors.red),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OKE',
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  ],
                ),
              ]),
            ));
  }

  Future<void> updateTitle(String id, String profesi) async {
    return userData
        .doc(id)
        .update({'profesi': profesi})
        .then((value) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(actions: [
                Column(
                  children: [
                    const Text(
                      'Data Berhasil DiUpdate',
                      style: TextStyle(color: Colors.green),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OKE',
                            style: TextStyle(color: Colors.blue),
                          )),
                    )
                  ],
                ),
              ]),
            ))
        .catchError((error) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(actions: [
                Column(
                  children: [
                    const Text(
                      'Error Menghapus Data',
                      style: TextStyle(color: Colors.red),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OKE',
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  ],
                ),
              ]),
            ));
  }

  Future<void> updateBiodata(String id, String biodata) async {
    return userData
        .doc(id)
        .update({'biodata': biodata})
        .then((value) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(actions: [
                Column(
                  children: [
                    const Text(
                      'Data Berhasil DiUpdate',
                      style: TextStyle(color: Colors.green),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OKE',
                            style: TextStyle(color: Colors.blue),
                          )),
                    )
                  ],
                ),
              ]),
            ))
        .catchError((error) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(actions: [
                Column(
                  children: [
                    const Text(
                      'Error Menghapus Data',
                      style: TextStyle(color: Colors.red),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OKE',
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  ],
                ),
              ]),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pengaturan"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            pengaturan(),
            const SizedBox(
              height: 40,
            ),
            buttonemail(),
            buttonpass(),
            buttonnama(),
            buttontitle(),
            buttonabout(),
            buttonlogout(),
          ],
        ),
      ),
    );
  }

  Widget pengaturan() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text("Back")),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 155),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text(
              'Pengaturan',
              style: TextStyle(
                fontSize: 20,
                //fontFamily: 'pridi',
              ),
            ),
          ),
        ],
      );

  Widget buttonemail() => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          width: 210,
          child: ElevatedButton.icon(
            onPressed: () async {
              await getDataUser();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(actions: [
                        Column(
                          children: [
                            TextFormField(
                              initialValue:
                                  "Email Lama : ${snapshots?['email']} ",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              "Email Baru : ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  hintText: ' ${snapshots?['email']}'),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        final docId = FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString();

                                        var alrdyUpdt =
                                            await updateEmail(docId, email!);

                                        if (alrdyUpdt != true) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(actions: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Data Berhasil DiUpdate',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  Center(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'OKE',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(actions: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Tidak Berhasil DiUpdate',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  Center(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'OKE',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          );
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
            },
            icon: const Icon(Icons.email_outlined),
            label: const Text('Ubah Email'),
          ),
        ),
      );

  Widget buttonnama() => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          width: 210,
          child: ElevatedButton.icon(
            onPressed: () async {
              await getDataUser();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(actions: [
                        Column(
                          children: [
                            TextFormField(
                              initialValue:
                                  "Nama Lama : ${snapshots?['nama']} ",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              "Nama Baru : ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  hintText: ' ${snapshots?['nama']}'),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        final docId = FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString();

                                        await updateNama(docId, email!);
                                      },
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {});
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
            },
            icon: const Icon(Icons.person),
            label: const Text('Ubah Nama'),
          ),
        ),
      );

  Widget buttonpass() => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          width: 210,
          child: ElevatedButton.icon(
            onPressed: () async {
              await getDataUser();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(actions: [
                        Column(
                          children: [
                            TextFormField(
                              initialValue:
                                  "Password Lama : ${snapshots?['password']} ",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              "Password Baru : ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextField(
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: InputDecoration(
                                  hintText: ' ${snapshots?['password']}'),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        final docId = FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString();

                                        var alrdyUpdt = await updatePassword(
                                            docId, password!);

                                        if (alrdyUpdt != true) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(actions: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Data Berhasil DiUpdate',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  Center(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'OKE',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(actions: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Tidak Berhasil DiUpdate',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  Center(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'OKE',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          );
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
            },
            icon: const Icon(Icons.password),
            label: const Text('Ubah Password'),
          ),
        ),
      );

  Widget buttontitle() => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          width: 210,
          child: ElevatedButton.icon(
            onPressed: () async {
              await getDataUser();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(actions: [
                        Column(
                          children: [
                            TextFormField(
                              initialValue:
                                  "Title Lama : ${snapshots?['profesi']} ",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              "Title Baru : ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  hintText: ' ${snapshots?['profesi']}'),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        final docId = FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString();

                                        await updateTitle(docId, email!);
                                      },
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {});
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
            },
            icon: const Icon(Icons.work),
            label: const Text('Ubah Title'),
          ),
        ),
      );

  Widget buttonabout() => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          width: 210,
          child: ElevatedButton.icon(
            onPressed: () async {
              await getDataUser();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(actions: [
                        Column(
                          children: [
                            TextFormField(
                              initialValue:
                                  "About Lama : ${snapshots?['biodata']} ",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              "About Baru : ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  hintText: ' ${snapshots?['biodata']}'),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        final docId = FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString();

                                        await updateBiodata(docId, email!);
                                      },
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {});
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
            },
            icon: const Icon(Icons.contact_page_sharp),
            label: const Text('Ubah Perkenalan'),
          ),
        ),
      );

  Widget buttonlogout() => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          width: 210,
          child: ElevatedButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ),
      );

  Widget backicon() => IconButton(
      alignment: Alignment.topLeft,
      onPressed: () {},
      icon: Icon(
        Icons.arrow_back,
        color: Colors.grey.shade600,
        size: 25,
      ));
}
