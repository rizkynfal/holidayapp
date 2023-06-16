// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget ImageQuoteCard() => Card(
  clipBehavior: Clip.antiAlias,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  child: Column(
    children: [
      Stack(
        children: [
          Ink.image(
            image: const NetworkImage(
              'https://storyblok-image.ef.com/unsafe/1500x750/filters:focal(960x375:961x376):quality(70)/f/78828/dd7b752616/ef-id-blog-top-banner-6-tips-wisata-ke-bromo-dari-malang.jpg',
            ),
            height: 240,
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
            child: const Text('Tambah ke Wishlist Destinasi'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('Forum'),
            onPressed: () {},
          )
        ],
      )
    ],
  ),
);