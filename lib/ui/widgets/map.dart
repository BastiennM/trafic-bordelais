import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafic_bordeaux/controller/home_controller.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.put(HomeController());

      return Obx(() => !_homeController.isLoadingPosition.value ? FlutterMap(
            options: MapOptions(
              center: LatLng(_homeController.currentPosition.value!.latitude, _homeController.currentPosition.value!.longitude),
              zoom: 16,
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
            ],
          ) : const Center(child: CircularProgressIndicator(color: Colors.black,)));
  }
}
