import 'package:flutter/material.dart';
import 'package:frontend/config/helpers/birdsDataService.dart';
import 'package:frontend/config/models/birdModel.dart';
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

  final getDataBirds = GetDataBirds();
  final List<Bird> birds = [];
  bool showBirds = false;
  int index = 0;

  final List<Widget> screens = [
    HomeScreen(),
    CameraScreen(),
    ProfileScreen(),
  ];


  @override
  void initState() {
    super.initState();
    _getBirds();
  }

  Future<void> _getBirds() async {
    try {
      var birds = await getDataBirds.getBirds();
      setState(() {
        birds = birds;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio"),
      ),
      body:Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("lib/interface/assets/background.jpeg"),
        fit: BoxFit.cover,
        ),
        ),
        child: screens[index],
      ),
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
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