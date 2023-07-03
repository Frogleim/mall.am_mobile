import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const String apiKey = 'AIzaSyD_4Quaad6a5-ULGV0t0l8ZFZoz-b4aY1E';
const defaultPadding = 16.0;
const Color primaryColor = Color(0xFF006491);
const Color textColorLightTheme = Color(0xFF0D0D0E);

const Color secondaryColor80LightTheme = Color(0xFF202225);
const Color secondaryColor60LightTheme = Color(0xFF313336);
const Color secondaryColor40LightTheme = Color(0xFF585858);
const Color secondaryColor20LightTheme = Color(0xFF787F84);
const Color secondaryColor10LightTheme = Color(0xFFEEEEEE);
const Color secondaryColor5LightTheme = Color(0xFFF8F8F8);

var success = Lottie.network(
    'https://assets2.lottiefiles.com/packages/lf20_jbrw3hcz.json',
    repeat: false);

var deliverySuccess = Lottie.network(
    'https://assets5.lottiefiles.com/packages/lf20_7foh1e6l.json',
    repeat: true);
