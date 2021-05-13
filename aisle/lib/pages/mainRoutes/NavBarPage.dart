import 'package:flutter/material.dart';
import 'package:aisle/style.dart';
import 'package:aisle/pages/mainRoutes/discover.dart';
import 'package:aisle/pages/mainRoutes/notes.dart';
import 'package:aisle/pages/mainRoutes/matches.dart';
import 'package:aisle/pages/mainRoutes/profile.dart';
import 'package:badges/badges.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key key}) : super(key: key);

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {

  var retIndex=0;
  List<Widget> widgets = [
    Discover(),
    Notes(),
    Matches(),
    Profile()
  ];

  handleOnTap(index){
    this.setState(() {
      retIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SetColors.background,
        body: widgets[retIndex],
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            iconSize: 50,
            onTap: handleOnTap,
            elevation: 0.0,
            selectedItemColor: Colors.black,
            unselectedItemColor: SetColors.disabled,
            showSelectedLabels: true,
            currentIndex: retIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'Discover',
                icon: ImageIcon(AssetImage(
                    "lib/assets/discover1.png")),
              ),
              BottomNavigationBarItem(
                label: 'Notes',
                icon: Badge(
                  shape: BadgeShape.circle,
                  badgeColor: SetColors.blipColor,
                  borderRadius: BorderRadius.circular(10),
                  child: ImageIcon(AssetImage(
                      "lib/assets/notes1.png")),
                  badgeContent: Container(
                    child: Text(notes_notificatio_number.toString(),style: TextTypes.light(Colors.white,15),),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Matches',
                icon: Badge(
                  shape: BadgeShape.circle,
                  badgeColor: SetColors.blipColor,
                  borderRadius: BorderRadius.circular(10),
                  child: ImageIcon(AssetImage(
                      "lib/assets/matches1.png")),
                  badgeContent: Container(
                    child: Text(matches_notification_number.toString(),style: TextTypes.light(Colors.white,15),),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: ImageIcon(AssetImage(
                    "lib/assets/profile1.png"))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
