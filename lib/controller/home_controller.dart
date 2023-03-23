import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafic_bordeaux/core/constants/enums.dart';
import 'package:trafic_bordeaux/models/address_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final client = http.Client();
  final RxString homeText = "Home text".obs;
  final Rx<Position?> currentPosition = Rx(null);
  final RxBool isLoadingPosition = true.obs;
  final Rx<TextEditingController> placeSearchController = TextEditingController().obs;
  final Rx<List<Widget>> itemsList = Rx([Container(width:100,color:Colors.red,child: const Text('a')),Container(width:100,color:Colors.green,child: const Text('a'))]);
  final FocusNode focus = FocusNode();
  final RxBool startSearching = false.obs;
  final txtList = TextEditingController();
  RxString controllerText = ''.obs;
  final addressListFull = <AddressModel>[].obs;
  final polylineToDisplay = <Polyline>[].obs;
  MapController mapController = MapController();
  final RxDouble zoom = 15.0.obs;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final Position position = await Geolocator.getCurrentPosition();
    isLoadingPosition.value = false;

    return position;
  }

  Future<void> createPolygones() async {
    for (int i = 0; i < addressListFull.length; i++) {
      List<LatLng> matricesCoordonnees = [];

      addressListFull.value[i].coordinates.forEach((element) {
        matricesCoordonnees.add(LatLng(element[1], element[0]));
      });

      List<LatLng> polyligneCoordonnees = [];
      for (int j = 0; j < matricesCoordonnees.length; j++) {
        polyligneCoordonnees.add(matricesCoordonnees[j]);
      }

      Polyline polyline = Polyline(
        points: polyligneCoordonnees,
        strokeWidth: 6,
        color: getColorByEtat(addressListFull.value[i].etat),
      );
      polylineToDisplay.add(polyline);
    }
  }

  void updatePolylines() {
    // Récupérez la zone visible de la carte
    LatLngBounds? visibleBounds = mapController.bounds;

    // Supprimez toutes les polylignes de la carte
    polylineToDisplay.clear();

    // Parcourez le tableau de matrices de coordonnées
    for (int i = 0; i < addressListFull.length; i++) {

      List<LatLng> matricesCoordonnees = [];

      addressListFull.value[i].coordinates.forEach((element) {
        matricesCoordonnees.add(LatLng(element[1], element[0]));
      });

      // Vérifiez si au moins un point se trouve dans la zone visible de la carte
      bool visible = false;
      for (int j = 0; j < matricesCoordonnees.length; j++) {
        LatLng point = matricesCoordonnees[j];
        if (visibleBounds!.contains(point)) {
          visible = true;
          break;
        }
      }

      // Si au moins un point se trouve dans la zone visible de la carte, ajoutez la polyligne à la carte
      if (visible) {
        List<LatLng> polyligneCoordonnees = [];
        for (int j = 0; j < matricesCoordonnees.length; j++) {
          polyligneCoordonnees.add(matricesCoordonnees[j]);
        }
        Polyline polyline = Polyline(
          points: polyligneCoordonnees,
          strokeWidth: 6,
          color: getColorByEtat(addressListFull.value[i].etat),
        );

        polylineToDisplay.value.add(polyline);
      }
    }
  }

  Future<void> fetchAllData() async {
    try {
      var response = await client.get(Uri.parse('https://data.bordeaux-metropole.fr/geojson?key=15CDJLPSTW&typename=ci_trafi_l&attributes=%5B%22gid%22,%22typevoie%22,%22etat%22,%22mdate%22,%22geom%22%5D'));

      var allData = json.decode(response.body) as Map<dynamic, dynamic>;

      for (var element in allData['features']) {
        addressListFull.add(AddressModel.fromMap(element));
      }
      } catch (e){
      print(e);
    }
  }

  Color getColorByEtat(String etat){
    EtatVoie finalEtat = matchEtatWithEnum(etat);
    switch (finalEtat) {
      case EtatVoie.INCONNU:
        return Colors.grey;
        break;
      case EtatVoie.FLUIDE:
        return Colors.green;
        break;
      case EtatVoie.EMBOUTEILLE:
        return Colors.red;
        break;
      case EtatVoie.DENSE:
        return Colors.orange;
        break;
      default:
        return Colors.grey;
    }
  }

  EtatVoie matchEtatWithEnum(String etat){
    switch (etat){
      case 'INCONNU':
        return EtatVoie.INCONNU;
      case 'FLUIDE':
        return EtatVoie.FLUIDE;
      case 'EMBOUTEILLE':
        return EtatVoie.EMBOUTEILLE;
      case 'DENSE':
        return EtatVoie.DENSE;
      default:
        return EtatVoie.INCONNU;
    }
  }

  @override
  onInit() async{
    super.onInit();
    await fetchAllData();
    await createPolygones();
    currentPosition.value = await determinePosition();
    txtList.addListener(() {
      controllerText.value = txtList.text;
    });
    debounce(controllerText, (_) {
      if(controllerText.value.isNotEmpty) startSearching.value = true;
      if(controllerText.value.isEmpty) startSearching.value = false;
      print("debouce$_");
    }, time: const Duration(seconds: 1));
  }
}
