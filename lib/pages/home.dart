import 'package:ek/Auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'history.dart';
import 'students.dart';
import 'settings.dart';
import 'index.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
    return false;
  }
  List<Widget> screens = [
    Index(),
    History(),
    Students(),
    Settings(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body:screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'QuickSand'),
          unselectedLabelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontFamily: 'QuickSand'),
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(

              icon: ImageIcon(AssetImage('assets/Icon/home.png'), size: 25, color: Colors.grey,),

              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/Icon/history.png'), size: 25, color: Colors.grey,),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/Icon/student.png'), size: 25, color: Colors.grey,),
              label: 'Students',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/Icon/settings.png'), size: 25, color: Colors.grey,),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
