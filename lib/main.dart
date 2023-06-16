import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ontime/check_login.dart';
import 'package:ontime/image_provider.dart';
import 'package:provider/provider.dart';
// import 'package:ontime/check_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageProvide(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mall.am',
        home: MainPage(),
      ),
    );
  }
}
