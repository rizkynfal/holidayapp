// ignore_for_file: file_names, use_build_context_synchronously
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liburan_app/wisata/gmaps.dart';

class DanauToba extends StatefulWidget {
  const DanauToba({Key? key}) : super(key: key);

  @override
  State<DanauToba> createState() => _DanauTobaState();
}

class _DanauTobaState extends State<DanauToba> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danau Toba"),
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
                'https://lh5.googleusercontent.com/p/AF1QipMm9XMGjCJlEp44FvJeJR_ABoJoMmwOJFcR7byY=w408-h256-k-no',
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  'Danau Toba',
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
              'Danau Toba adalah danau alami berukuran besar di Indonesia yang berada di kaldera gunung supervulkan. Danau ini memiliki panjang 100 kilometer, lebar 30 kilometer, dan kedalaman 508 meter. Danau ini terletak di tengah pulau Sumatra bagian utara dengan ketinggian permukaan sekitar 900 meter.',
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

                    for (var i = favPlace.length; i < favPlace.length; i--) {
                      if (favPlace[i].toString() == "Danau Toba") {
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
                        favPlace.add("Danau Toba");
                        break;
                      }
                    }
                    final data = await userData
                        .doc(docId)
                        .update({'favorit_place': favPlace});
                  } catch (e) {
                    const CircularProgressIndicator();
                  }
                },
              ),
              TextButton(
                child: const Text('Lihat di Map'),
                onPressed: () {
                  String title = "Danau Toba";
                  double latitude = 2.7787718810567554;
                  double longitude = 98.76039113587497;
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
