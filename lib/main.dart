import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/model/auth_provider.dart';
import 'package:storage/model/task_provider.dart';
import 'package:storage/ui/splash_page.dart';

void main() async {
  runApp(const StorageApp());
}

class StorageApp extends StatelessWidget {
  const StorageApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Storage Demo',
      home: SplashPage(),
    );
  }
}
