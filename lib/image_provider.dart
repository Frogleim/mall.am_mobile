import 'package:flutter/material.dart';

class ImageProvide with ChangeNotifier {
  String _imageUrl = '';

  String get imageUrl => _imageUrl;

  set imageUrl(String url) {
    _imageUrl = url;
    notifyListeners();
  }
}
