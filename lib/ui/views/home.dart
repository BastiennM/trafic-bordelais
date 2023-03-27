import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import 'package:trafic_bordeaux/controller/timer_controller.dart';
import 'package:trafic_bordeaux/models/search_address_model.dart';
import 'package:trafic_bordeaux/ui/widgets/map.dart';
import 'package:trafic_bordeaux/ui/widgets/snackbar.dart';
import 'package:trafic_bordeaux/ui/widgets/state_road_indicator.dart';
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
  TimerController timerController = Get.put(TimerController());
  HomeController homeController = Get.find<HomeController>();

  buildSnackbar() {
    return CustomSnackbar().buildSnackbar(
        'Etat de la zone actuelle',
        'La zone est ${homeController.currentRoadState.value.name}',
        StateRoadIndicator()
            .getTypeMessage(homeController.currentRoadState.value),
        position: SnackPosition.TOP,
        duration: 6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: [
            const MapWidget(),
            getProfileButton(),
            getBottomContainer(),
            getRoadStateIndicator(),
            getRefreshMapWidget()
          ],
        ),
      ),
    );
  }

  Widget getProfileButton() {
    return Obx(
      () => Visibility(
        visible: !homeController.isLoadingPosition.value,
        child: Positioned(
          top: 60,
          left: 15,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: !themeModeController.isDark.value
                    ? ColorPalette.darkGrey300
                    : Colors.white,
                borderRadius: BorderRadius.circular(14.0)),
            child: CustomIconButton(
              onPressed: () {
                Get.toNamed('/profil');
              },
              icon: Icon(
                Icons.person,
                color: themeModeController.isDark.value
                    ? Colors.black
                    : Colors.white,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget getBottomContainer() {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(18.0),
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: !themeModeController.isDark.value
              ? ColorPalette.darkGrey300
              : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                    controller: homeController.placeSearchController),
                Obx(
                  () => Visibility(
                    visible: homeController.searchString.value != "",
                    child: Positioned(
                      right: 14,
                      top: 15,
                      child: InkWell(
                          onTap: () => homeController.emptySearch(),
                          child: const Icon(Icons.close,
                              color: ColorPalette.greyBack, size: 18)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Obx(() => Container(height: 100, child: doSearchLogic()))
          ],
        ),
      ),
    );
  }

  Widget getRoadStateIndicator() {
    return Obx(
      () => Visibility(
        visible: !homeController.isLoadingPosition.value,
        child: Positioned(
          top: 60,
          right: 15,
          child: InkWell(
            onTap: () => buildSnackbar(),
            child: StateRoadIndicator()
                .getRoadIndicator(homeController.currentRoadState.value),
          ),
        ),
      ),
    );
  }

  Widget getListResultSearch() {
    return MediaQuery.removePadding(
      context: Get.context!,
      removeTop: true,
      child: ListView.separated(
          itemCount: homeController.addressListSearch.value.length,
          itemBuilder: (BuildContext context, int index) {
            SearchAdressModel item =
                homeController.addressListSearch.value[index];

            return Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: ColorPalette.grey50,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () {
                  homeController.mapController
                      .move(LatLng(item.latitude, item.longitude), 18);
                  homeController.listMarker.value.add(Marker(
                      point: LatLng(item.latitude, item.longitude),
                      builder: (BuildContext context) {
                        return const Icon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.red,
                          size: 28,
                        );
                      }));
                  buildSnackbar();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.pin_drop),
                    Text(item.name),
                    const SizedBox.shrink()
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              )),
    );
  }

  Widget getEmptyResult() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.only(top: 28.0),
      child: Text('c\'est vide'),
    ));
  }

  Widget getNotEnoughLetterResult() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.only(top: 28.0),
      child: Text('l\'adresse doit f aire au moins 3 carac'),
    ));
  }

  Widget doSearchLogic() {
    Widget widgetToReturn =
        const Center(child: CircularProgressIndicator(color: Colors.black));

    if (homeController.searchString.value.length < 3) {
      widgetToReturn = getNotEnoughLetterResult();
    }

    if (!homeController.startSearching.value) {
      if (homeController.emptyAfterSearch.value) {
        widgetToReturn = getEmptyResult();
      }
      if (homeController.addressListSearch.value.isNotEmpty) {
        widgetToReturn = getListResultSearch();
      } else if (homeController.addressListSearch.value.isEmpty &&
          homeController.searchString.value == "") {
        widgetToReturn = const Center(child: Text('Commencez à rechercher une adresse !'));
      }
    }

    return widgetToReturn;
  }

  Widget getRefreshMapWidget() {
    return Positioned(
      bottom: 200,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color:ColorPalette.grey100)
                  ),
                  child: Row(

                    children: [
                      const Text('Rafraichissement des données dans :'),
                      const SizedBox(width:5),
                      Obx(() => Text(timerController.getFormattedTime(),style: const TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color:ColorPalette.grey100)
              ),
                padding: const EdgeInsets.all(8.0),
                child: Obx(()=> InkWell(
                    onTap: () => timerController.canReset.value ? timerController.resetTimer() : null,
                      child: Icon(Icons.refresh, color: timerController.canReset.value ? Colors.black : ColorPalette.grey200)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
