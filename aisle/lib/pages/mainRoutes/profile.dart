import 'package:aisle/style.dart';
import 'package:flutter/material.dart';
import 'package:aisle/pages/phoneNumberPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.background,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: SetColors.buttonBackground,
            borderRadius: BorderRadius.circular(100),
          ),
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove("token");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>PhoneNumberPage()), (route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: Text("Logout",style: TextTypes.main(Colors.black,15.0),),
            ),
          ),
        ),
      ),
    );
  }
}
