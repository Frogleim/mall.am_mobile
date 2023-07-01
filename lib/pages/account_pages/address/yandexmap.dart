import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMp extends StatefulWidget {
  const YandexMp({super.key});

  @override
  State<YandexMp> createState() => _YandexMpState();
}

class _YandexMpState extends State<YandexMp> {
  YandexMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(),
    );
  }
}
