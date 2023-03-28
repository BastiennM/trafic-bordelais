import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/home_controller.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    ThemeModeController themeModeController = Get.find<ThemeModeController>();

      return Obx(() => !homeController.isLoadingPosition.value ? FlutterMap(
        mapController: homeController.mapController,
            options: MapOptions(
              center: homeController.currentPosition.value,
              zoom: homeController.zoom.value,
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              maxZoom: 18, //Here to avoid grey screen
              onPositionChanged: (_, __) {
                if (homeController.zoom.value != homeController.mapController.zoom) {
                  homeController.zoom.value = homeController.mapController.zoom;
                  homeController.updatePolylines();
                  return;
                }
                homeController.updatePolylines();
              },
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
            children: [
              TileLayer(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  tileBuilder: themeModeController.isDark.value ? null : darkModeTileBuilder,
              ),
              Obx(() => MarkerLayer(
                markers: homeController.listMarker.value,
              )),
              Obx(() => (
                  PolylineLayer(
                      polylines: homeController.polylineToDisplay.value
                  )
              )),
            ],
          ) : const Center(child: CircularProgressIndicator(color: Colors.black,)));
  }

  Widget darkModeTileBuilder(
      BuildContext context,
      Widget tileWidget,
      Tile tile,
      ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.9, 0, 0, 0, -15,
        0, 0.9, 0, 0, -15,
        0, 0, 0.9, 0, -15,
        0, 0, 0, 1, 0,
      ]),
      child: tileWidget,
    );
  }
}



