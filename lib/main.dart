import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ontime/auth/check_login.dart';
import 'package:ontime/models/image_provider/image_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageProvide(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mall.am',
        home: MainPage(),
      ),
    );
  }
}
