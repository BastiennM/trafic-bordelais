import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafic_bordeaux/controller/home_controller.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

      return Obx(() => !homeController.isLoadingPosition.value ? FlutterMap(
        mapController: homeController.mapController,
            options: MapOptions(
              center: LatLng(homeController.currentPosition.value!.latitude, homeController.currentPosition.value!.longitude),
              zoom: homeController.zoom.value,
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
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              Obx(() => (
                  PolylineLayer(
                      polylines: homeController.polylineToDisplay.value
                  )
              )),
            ],
          ) : const Center(child: CircularProgressIndicator(color: Colors.black,)));
  }
}
