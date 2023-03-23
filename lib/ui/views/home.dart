import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import 'package:trafic_bordeaux/ui/widgets/map.dart';
import 'package:trafic_bordeaux/ui/widgets/textfield.dart';
import '../../controller/home_controller.dart';
import '../../core/constants/color_palette.dart';
import '../widgets/icon_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ThemeModeController themeModeController = Get.put(ThemeModeController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
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
            color: !themeModeController.isDark.value ? ColorPalette.darkGrey300 : Colors.white, borderRadius: BorderRadius.circular(14.0)),
        child: CustomIconButton(
          onPressed: () {
            Get.toNamed('/profil');
          },
          icon: Icon(
            Icons.person,
            color: themeModeController.isDark.value ? Colors.black : Colors.white,
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
        maxChildSize: 0.50,
        snap: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: !themeModeController.isDark.value ? ColorPalette.darkGrey300 : Colors.white,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                        controller: homeController.txtList),
                    const SizedBox(height: 25),
                Obx(() => !homeController.startSearching.value ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getFavoritePlaces(FontAwesomeIcons.house),
                        getFavoritePlaces(FontAwesomeIcons.building)
                      ],
                    ) : const Center(child: CircularProgressIndicator(color: Colors.black,)))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getFavoritePlaces(IconData icon) {
    return Container(
        width: 174,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorPalette.grey100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                FaIcon(icon, color: Colors.black,),
                const SizedBox(width: 20,),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text('Maison', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 3,),
                      Text('31 rue des champs', overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodySmall,)
                    ],
                  ),
                ),
              ],
            ),

        )
    );
  }
}
