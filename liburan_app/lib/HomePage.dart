// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:liburan_app/MyProfile/MyPref.dart';
import 'package:liburan_app/MyProfile/MyProfile.dart';
import 'package:liburan_app/wisata/bromo.dart';
import 'package:liburan_app/wisata/danauToba.dart';
import 'package:liburan_app/wisata/tamanLautBunaken.dart';
import 'package:liburan_app/wisata/wakatobi.dart';
import 'package:liburan_app/wisata/lembang.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double coverHeight = 200;
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 15,
        title: Image.asset(
          'assets/images/liburan.png',
          height: 200.0,
          width: 200.0,
        ),
        actions: [
          navigasiSetting(),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: profilePicture(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfile(
                      title: "My Profile",
                    ),
                  ),
                );
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          bestweek(),
          navigasiArea2(),
          navigasiArea3(),
          navigasiArea1(),
          danauToba(),
          tamanLautBunaken()
        ],
      ),
    );
  }

  Widget tamanLautBunaken() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TamanLautBunaken(),
            ),
          );
        },
        child: area5(),
      );
  Widget danauToba() => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DanauToba(),
            ),
          );
        },
        child: area4(),
      );
  Widget profilePicture() => Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec',
            ),
          ),
        ),
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

  Widget bestweek() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: const Text(
          'Rekomendasi Lokasi Wisata Minggu Ini',
          style: TextStyle(
            fontSize: 18,
            //fontFamily: 'pridi',
          ),
        ),
      );

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
          ),
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

  Widget area4() => Stack(
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
      );

  Widget area5() => Stack(
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
      );
}
