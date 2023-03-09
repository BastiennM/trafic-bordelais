import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/ui/widgets/map.dart';

import '../../controller/home_controller.dart';
import '../widgets/icon_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapWidget(),
          getProfileButton()
        ],
      ),
    );
  }

  Widget getProfileButton() {
    return Positioned(
      top: 60,
      left: 15,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14.0)),
        child: CustomIconButton(
          onPressed: () {
            Get.toNamed('/profil');
          },
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
