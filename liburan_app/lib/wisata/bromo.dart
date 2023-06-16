// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liburan_app/wisata/gmaps.dart';

class Bromo extends StatefulWidget {
  const Bromo({Key? key}) : super(key: key);

  @override
  State<Bromo> createState() => _BromoState();
}

class _BromoState extends State<Bromo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gunung Bromo"),
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
                'https://storyblok-image.ef.com/unsafe/1500x750/filters:focal(960x375:961x376):quality(70)/f/78828/dd7b752616/ef-id-blog-top-banner-6-tips-wisata-ke-bromo-dari-malang.jpg',
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  'Gunung Bromo',
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
              'Gunung Bromo atau dalam bahasa Tengger dieja "Brama", juga disebut Kaldera Tengger, adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur.',
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
                      if (favPlace[i].toString() == "Bromo") {
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
                        favPlace.add("Bromo");
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
                  String title = "Gunung Bromo";
                  double latitude = -8.016506045443382;
                  double longitude = 112.94627432082069;
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
              'Devina',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Akhirnya Liburan Juga, waktunya hiking.. ',
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
              'Athalla',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Lepaskan semua penat hidup ini di gunung Bromo, rekomendasi buat tempat meditasi.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
