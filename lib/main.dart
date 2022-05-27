import 'package:flutter/material.dart';
import 'package:storage/ui/splash_page.dart';

void main() {
  runApp(const StorageApp());
}

class StorageApp extends StatelessWidget {
  const StorageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Storage Demo',
      home: SplashPage(),
    );
  }
}
