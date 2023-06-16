// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liburan_app/wisata/gmaps.dart';

class Lembang extends StatefulWidget {
  const Lembang({Key? key}) : super(key: key);

  @override
  State<Lembang> createState() => _LembangState();
}

class _LembangState extends State<Lembang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lembang"),
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
                'https://www.pinhome.id/info-area/wp-content/uploads/2022/03/WIsata-ALam-Lembang.jpg',
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  'Lembang',
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
              'Lembang adalah sebuah kecamatan di Kabupaten Bandung Barat, Jawa Barat, Indonesia. Kecamatan ini berjarak sekitar 22 Kilometer dari ibu kota kabupaten Bandung Barat ke arah timur laut melalui Cisarua. Pusat pemerintahannya berada di Desa Lembang. Kecamatan Lembang merupakan kecamatan paling timur dan terkenal sebagai tujuan wisata di Jawa Barat.',
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
                      if (favPlace[i].toString() == "Lembang") {
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
                        favPlace.add("Lembang");
                        break;
                      }
                    } final data = await userData
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
                  String title = "Lembang";
                  double latitude = -6.808620481914348;
                  double longitude = 107.62187157809029;
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
              'Athalla',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Akhirnya liburan juga, temen ada yang nitip beli bolu lembang nih ',
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
              'Lepaskan semua penat hidup ini di Lembang, rekomendasi buat tempat cari inspirasi.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
