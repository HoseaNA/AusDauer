import 'package:flutter/material.dart';

import 'package:aus_dauer/pages/marketplace.dart';
import 'package:aus_dauer/pages/manage_product.dart';
import 'package:aus_dauer/pages/add_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flut",
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      home: const MarketplacePage(),
    );
  }
}
