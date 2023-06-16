// ignore_for_file: file_names
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liburan_app/MyProfile/MyPref.dart';
import 'package:liburan_app/wisata/bromo.dart';
import 'package:liburan_app/wisata/favoritePlaece.dart';
import 'package:liburan_app/wisata/wakatobi.dart';
import 'package:liburan_app/wisata/lembang.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  final double coverHeight = 200;
  final double profileHeight = 120;
  var userCredential = FirebaseAuth.instance;
  final userData = FirebaseFirestore.instance.collection('users');
  Map<String, dynamic>? snapshots;
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
      getDataUser();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [navigasiSetting()],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: <Widget>[
            toppart(),
            contentprofile(),
            contentabout(),
            const FavoritePlace()
          ],
        ),
      ),
    );
  }

  Widget navigasiArea2() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Bromo(),
            ),
          );
        },
        child: area2(),
      );

  Widget navigasiArea3() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Wakatobi(),
            ),
          );
        },
        child: area3(),
      );

  Widget navigasiArea1() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Lembang(),
            ),
          );
        },
        child: area1(),
      );

  Widget navigasiSetting() => IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyPref(),
            ),
          );
        },
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
      );

  Widget coverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://storyblok-image.ef.com/unsafe/1500x750/filters:focal(960x375:961x376):quality(70)/f/78828/dd7b752616/ef-id-blog-top-banner-6-tips-wisata-ke-bromo-dari-malang.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget profileImage() => CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey,
      backgroundImage: const NetworkImage(
          'https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec'));

  Widget contentprofile() => Container(
        margin: const EdgeInsets.only(left: 130),
        //padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Nama : ${snapshots?['nama'] ?? 'nama'}",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(iconColor: Colors.black),
                        onPressed: () {navigasiSetting();},
                        child: const Icon(Icons.edit_outlined))
                  ]),
            ),
            Card(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Title: ${snapshots?['profesi'] ?? "profesi"}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(iconColor: Colors.black),
                        onPressed: () {navigasiSetting();},
                        child: const Icon(Icons.edit_outlined))
                  ]),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(14),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'About Me',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(iconColor: Colors.black),
                          onPressed: () {navigasiSetting();},
                          child: const Icon(Icons.edit_outlined)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${snapshots?['biodata'] ?? "biodata"}",
                          style: const TextStyle(
                            fontSize: 12,
                            //fontFamily: 'pridi',
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );

  Widget contentabout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Favorite Place To Visit',
                style: TextStyle(
                  fontSize: 20,
                  //fontFamily: 'pridi',
                ),
              ),
            ),
          ],
        ),
      );

  Widget toppart() {
    final jartengah = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 0),
          //margin: EdgeInsets.only(bottom: jarbawah),
          child: coverImage(),
        ),
        Positioned(
          top: jartengah,
          left: 5,
          child: profileImage(),
        ),
      ],
    );
  }

  Widget settingicon() => IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.settings,
        color: Colors.white,
        size: 25,
      ));

  Widget area1() => Stack(
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
          )
        ],
      );

  Widget area2() => Stack(
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
      );

  Widget area3() => Stack(
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
      );
}
