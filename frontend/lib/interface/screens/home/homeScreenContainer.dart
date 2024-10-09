import 'package:flutter/material.dart';
import 'package:frontend/config/theme/appTheme.dart';
import 'package:frontend/interface/screens/user/cameraScreen.dart';
import 'package:frontend/interface/screens/user/profileScreen.dart';
import 'package:frontend/interface/screens/home/homeScreen.dart';


class HomeScreenContainer extends StatefulWidget {
  const HomeScreenContainer({super.key});

  static const String name = 'HomeScreenContainer';

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {


  int index = 0;

  final List<Widget> screens = [
    HomeScreen(),
    CameraScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio", style: TextStyle(color: Colors.white),),
        backgroundColor: AppTheme.verdeOscuro,

      ),
      body: screens[index],
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: AppTheme.verdeOscuro,
        onTap: (index) {
          setState(() {
            index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, size: 30.0, color: Colors.white),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30.0, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}