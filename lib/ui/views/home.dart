import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/ui/widgets/map.dart';
import 'package:trafic_bordeaux/ui/widgets/textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../controller/home_controller.dart';
import '../../core/constants/color_palette.dart';
import '../widgets/icon_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: [
            const MapWidget(),
            getProfileButton(),
            getBottomDraggable(homeController)
          ],
        ),
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

  Widget getBottomDraggable(HomeController homeController) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 0.25,
        minChildSize: 0.25,
        maxChildSize: 0.25,
        snap: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                        fillColor: ColorPalette.grey50,
                        prefix: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 16,
                        ),
                        label: "Rechercher un lieu",
                        borderColor: Colors.white,
                        circularBorder: 12,
                        controller: homeController.placeSearchController.value),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getFavoritePlaces(),
                        getFavoritePlaces()
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getFavoritePlaces() {
    return Container(
        width: 160,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorPalette.grey100),
        ));
  }
}
