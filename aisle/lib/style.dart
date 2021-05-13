import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SetColors {
  static const background = const Color(0xFFF2F2F2);
  static const disabled = const Color(0xFF9B9B9B);
  static const buttonBackground = const Color(0xFFF9CB10);
  static const blipColor = const Color(0xFF8C5CFB);
  static const borderColor = const Color(0xFFC4C4C4);
}

class TextTypes {
  static TextStyle light(Color color,double fontSize){
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
    );
  }
  static TextStyle main(Color color,double fontSize){
    return TextStyle(
        fontWeight: FontWeight.w800,
        color: color,
        fontSize: fontSize,
        fontStyle: FontStyle.normal
    );
  }
  static TextStyle input(Color color,double fontSize){
    return TextStyle(
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: fontSize,
        fontStyle: FontStyle.normal
    );
  }
}

var Loader = Container(child: SpinKitRotatingCircle(
  color: Colors.black,
  size: 50.0,
),color: SetColors.buttonBackground,);
var userData = {};
var home_notification_number = "50";
var notes_notificatio_number = "12";
var matches_notification_number = "50+";