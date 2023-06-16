// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liburan_app/wisata/bromo.dart';
import 'package:liburan_app/wisata/danauToba.dart';
import 'package:liburan_app/wisata/lembang.dart';
import 'package:liburan_app/wisata/tamanLautBunaken.dart';
import 'package:liburan_app/wisata/wakatobi.dart';

class FavoritePlace extends StatefulWidget {
  const FavoritePlace({super.key});

  @override
  State<FavoritePlace> createState() => _FavoritePlaceState();
}

class _FavoritePlaceState extends State<FavoritePlace> {
  var userCredential = FirebaseAuth.instance;
  late String uid = userCredential.currentUser!.uid;
  late Stream<DocumentSnapshot> documentStream =
      FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: documentStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went Wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
       
          var favPlaceCard = <Widget>[];

          Map<String, dynamic> tes =
              snapshot.data!.data()! as Map<String, dynamic>;
          List favPlace = tes['favorit_place'];
          for (var i = 0; i < favPlace.length; i++) {
         
            if (favPlace[i].toString() == "Wakatobi") {
              favPlaceCard.add(toWakatobi());
            } else if (favPlace[i].toString() == "Bromo") {
              favPlaceCard.add(toBromo());
            } else if (favPlace[i].toString() == "Lembang") {
              favPlaceCard.add(toLembang());
            } else if (favPlace[i].toString() == "Danau Toba") {
              favPlaceCard.add(toDanauToba());
            } else if (favPlace[i].toString() == "Taman Laut Bunaken") {
              favPlaceCard.add(toTamanLautBunaken());
            } else if (favPlace[i].toString() == "Lembang") {
              favPlaceCard.add(toLembang());
            }
             
          }

          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: favPlaceCard,
              ));
        }
      },
    );
  }

  Widget toTamanLautBunaken() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TamanLautBunaken(),
            ),
          );
        },
        child: tamanLautBunaken(),
      );
  Widget toDanauToba() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DanauToba(),
            ),
          );
        },
        child: danauToba(),
      );

  Widget toBromo() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Bromo(),
            ),
          );
        },
        child: bromo(),
      );

  Widget toWakatobi() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Wakatobi(),
            ),
          );
        },
        child: wakaTobi(),
      );

  Widget toLembang() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Lembang(),
            ),
          );
        },
        child: lembang(),
      );
  Widget lembang() => SizedBox(
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                height: 100,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://www.pinhome.id/info-area/wp-content/uploads/2022/03/WIsata-ALam-Lembang.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 36),
                //alignment: Alignment.center,
                child: const Text(
                  "Lembang",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );

  Widget bromo() => SizedBox(
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                height: 100,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://storyblok-image.ef.com/unsafe/1500x750/filters:focal(960x375:961x376):quality(70)/f/78828/dd7b752616/ef-id-blog-top-banner-6-tips-wisata-ke-bromo-dari-malang.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 36),
                //alignment: Alignment.center,
                child: const Text(
                  "Bromo",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      );

  Widget wakaTobi() => SizedBox(
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                height: 100,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://img.okezone.com/content/2021/09/16/25/2472201/4-daya-tarik-wakatobi-surga-wisata-di-timur-indonesia-j3JLuQsHI2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 36),
                //alignment: Alignment.center,
                child: const Text(
                  "Wakatobi",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      );

  Widget danauToba() => SizedBox(
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                height: 100,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://waspada.co.id/wp-content/uploads/2022/03/Misteri-Dibalik-Keindahan-Danau-Toba-Menyimpan-Cerita-Mistis-2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 36),
                //alignment: Alignment.center,
                child: const Text(
                  "Danau Toba",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      );

  Widget tamanLautBunaken() => SizedBox(
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                height: 100,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://ecs7.tokopedia.net/blog-tokopedia-com/uploads/2020/01/ikan-laut-1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 36),
                //alignment: Alignment.center,
                child: const Text(
                  "Taman Laut Bunaken",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      );
}
