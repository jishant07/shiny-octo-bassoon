import 'package:flutter/material.dart';
import 'package:aisle/style.dart';

class Matches extends StatefulWidget {
  const Matches({Key key}) : super(key: key);

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.background,
      body: Center(child: Text("Matches Page"),),
    );
  }
}
