import 'package:aus_dauer/pages/product_detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductDetail(),
    );
  }
}
