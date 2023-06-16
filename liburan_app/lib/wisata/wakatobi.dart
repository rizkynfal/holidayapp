// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liburan_app/wisata/gmaps.dart';

class Wakatobi extends StatefulWidget {
  const Wakatobi({Key? key}) : super(key: key);

  @override
  State<Wakatobi> createState() => _WakatobiState();
}

class _WakatobiState extends State<Wakatobi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taman Nasional Wakatobi"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ImageQuoteCard(context),
          Komentar(),
          QuoteCard(),
          QuoteCard1()
        ],
      ),
    );
  }
}

Widget Komentar() => Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: const Text(
        'Komentar',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
Widget ImageQuoteCard(BuildContext context) => Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://img.okezone.com/content/2021/09/16/25/2472201/4-daya-tarik-wakatobi-surga-wisata-di-timur-indonesia-j3JLuQsHI2.jpg',
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  'Taman Nasional Wakatobi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: const Text(
              'Taman Nasional Wakatobi adalah salah satu taman nasional di Indonesia. Letaknya di Kabupaten Wakatobi, Sulawesi Tenggara. Taman nasional ini ditetapkan pada tanggal 19 Agustus tahun 2002 berdasarkan Surat Keputusan Menteri kehutanan Nomor 7661/Kpts-II/2002. Lahan yang dipakai seluas 1,39 juta hektare. Sebelumnya, taman nasional ini juga telah ditetapkan oleh Surat Keputusan Menteri Kehutanan Nomor 393/Kpts-V/1996.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                child: const Text('Tambah ke Favorite'),
                onPressed: () async {
                  var userData = FirebaseFirestore.instance.collection('users');
                  final docId =
                      FirebaseAuth.instance.currentUser!.uid.toString();
                  Map<String, dynamic>? snapshots;
                  try {
                    var newData = await userData.doc(docId).get();
                    snapshots = newData.data()!;
                    List favPlace = snapshots['favorit_place'];
                    for (var i = 0; i < favPlace.length; i++) {
                      if (favPlace[i].toString() == "Wakatobi") {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Data Favorit Telah Ada !'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        favPlace.add("Wakatobi");
                        break;
                      }
                    }
                    final data = await userData
                        .doc(docId)
                        .update({'favorit_place': favPlace});
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              TextButton(
                child: const Text('Lihat di Map'),
                onPressed: () {
                  String title = "Wakatobi";
                  double latitude = -5.631506828016949;
                  double longitude = 123.89031322687609;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMaps(
                          title: title,
                          latitude: latitude,
                          longitude: longitude),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
Widget QuoteCard() => Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Jessica',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Gass berenang',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
Widget QuoteCard1() => Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Devina',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Banyak hidden gems spot nih disini.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
