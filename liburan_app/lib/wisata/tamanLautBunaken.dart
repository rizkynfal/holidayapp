// ignore_for_file: file_names, use_build_context_synchronously
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liburan_app/wisata/gmaps.dart';

class TamanLautBunaken extends StatefulWidget {
  const TamanLautBunaken({Key? key}) : super(key: key);

  @override
  State<TamanLautBunaken> createState() => _TamanLautBunakenState();
}

class _TamanLautBunakenState extends State<TamanLautBunaken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taman Laut Bunaken"),
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
                'https://ecs7.tokopedia.net/blog-tokopedia-com/uploads/2020/01/ikan-laut-1.jpg',
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  'Taman Laut Bunaken',
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
                    List alrdyPlace = [];
                    for (var i = 0; i < favPlace.length; i++) {
                      if (favPlace[i].toString() == "Taman Laut Bunaken") {
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
                        favPlace.add("Taman Laut Bunaken");
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
                  String title = "Taman Laut Bunaken";
                  double latitude = 1.6781147675230161;
                  double longitude = 124.75594103229469;
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
