// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget QuoteCard() => Card(
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '"Akhirnya debug kelar juga, waktunya hiking bosque."',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 12),
        Text(
          'Athalla',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
);
