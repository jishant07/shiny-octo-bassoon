import 'package:aisle/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aisle/pages/phoneNumberPage.dart';

void main () async {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Inter",backgroundColor: SetColors.background),
      initialRoute:"/",
      routes:{
        "/": (context) => PhoneNumberPage(),
      }
    )
  );
}