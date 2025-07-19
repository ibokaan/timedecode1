import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black, // Arka planı siyah yap
      body: Padding(
        padding: EdgeInsets.only(top: 50), // Yukarıdan boşluk (başlık gibi)
        child: Align(
          alignment: Alignment.topCenter, // Yazıyı yukarı ortala
          child: Text(
            'TimeDecode',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Yazı rengi beyaz
            ),
          ),
        ),
      ),
    ),
  ));
}

