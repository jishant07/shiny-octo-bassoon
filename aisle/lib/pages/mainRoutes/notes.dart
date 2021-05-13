import 'package:flutter/material.dart';
import 'package:aisle/style.dart';


class Notes extends StatefulWidget {
  const Notes({Key key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.background,
      body: Center(child: Text("Notes Page"),),
    );
  }
}
