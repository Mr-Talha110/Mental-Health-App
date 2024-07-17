import 'package:caress/ArticlesPage.dart';
import 'package:caress/ProfilePage.dart';
import 'package:caress/UserScreen.dart';
import 'package:caress/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [const UserData(), const Articles(), const Profile()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.health_and_safety),
        title: ("Vitals"),
        activeColorPrimary: Colors.redAccent.withOpacity(0.8),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper),
        title: ("Articles"),
        activeColorPrimary: Colors.redAccent.withOpacity(0.8),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.redAccent.withOpacity(0.8),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  void getcredentials() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${PatientInfo.email}')
        .get();
    setState(() {
      PatientInfo.name = doc['name'];
      PatientInfo.friendName = doc['friend'];
      PatientInfo.friendContact = doc['friendContact'];
      PatientInfo.phoneNo = doc['friendPhone'];
      PatientInfo.specialistName = doc['specialist'];
      PatientInfo.specialistContact = doc['specialistContact'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getcredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true, // Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
