import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafic_bordeaux/core/constants/constants.dart';
import 'package:trafic_bordeaux/core/constants/enums.dart';
import 'package:trafic_bordeaux/core/utils/map_utils.dart';
import 'package:trafic_bordeaux/models/address_model.dart';
import 'package:http/http.dart' as http;
import 'package:trafic_bordeaux/models/search_address_model.dart';

class HomeController extends GetxController {
  final client = http.Client();
  final RxString homeText = "Home text".obs;
  final Rx<LatLng?> currentPosition = Rx(null);
  final RxBool isLoadingPosition = true.obs;
  final RxBool emptyAfterSearch = false.obs;
  final FocusNode focus = FocusNode();
  final RxBool startSearching = false.obs;
  final placeSearchController = TextEditingController();
  RxString searchString = ''.obs;
  final addressListFull = <AddressModel>[].obs;
  final addressListSearch = <SearchAdressModel>[].obs;
  final polylineToDisplay = <Polyline>[].obs;
  MapController mapController = MapController();
  final RxDouble zoom = 18.0.obs;
  final listMarker = <Marker>[].obs;
  final currentRoadState = EtatVoie.FLUIDE.obs;
  final List<EtatVoie> visibleStateRoadList = [];

  Future<LatLng> determinePosition() async {
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
    
    Position position = await Geolocator.getCurrentPosition();
    
    if (isInSquare(position.longitude, position.latitude)) {
      isLoadingPosition.value = false;
      return LatLng(position.latitude, position.longitude);
    } else {
      isLoadingPosition.value = false;
      return LatLng(44.8386935779402, -0.56946910799683); //Centre de bordeaux
    }

  }
  
  Future<void> createPolylines() async {

    visibleStateRoadList.clear(); //Resetting array values

    for (int i = 0; i < addressListFull.length; i++) {
      List<LatLng> matricesCoordonnees = [];

      addressListFull.value[i].coordinates.forEach((element) {
        matricesCoordonnees.add(LatLng(element[1], element[0]));
      });

      List<LatLng> polyligneCoordonnees = [];
      EtatVoie etatVoie = matchEtatWithEnum(addressListFull[i].etat);
      visibleStateRoadList.add(etatVoie);

      for (int j = 0; j < matricesCoordonnees.length; j++) {
        polyligneCoordonnees.add(matricesCoordonnees[j]);
      }

      Polyline polyline = Polyline(
        points: polyligneCoordonnees,
        strokeWidth: 5,
        color: getColorByEtat(addressListFull.value[i].etat),
      );
      polylineToDisplay.add(polyline);
    }

    updateStateRoad(getMostFrequent(visibleStateRoadList));
  }

  void updateStateRoad(EtatVoie etatVoie) {
    currentRoadState.value = etatVoie;
  }

  void updatePolylines() {
    visibleStateRoadList.clear(); //Resetting array values

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
        EtatVoie etatVoie = matchEtatWithEnum(addressListFull[i].etat);

        if (visibleBounds!.contains(point)) {
          visibleStateRoadList.add(etatVoie);
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
          strokeWidth: 5,
          color: getColorByEtat(addressListFull.value[i].etat),
        );

        polylineToDisplay.value.add(polyline);
      }
    }

    updateStateRoad(getMostFrequent(visibleStateRoadList));
  }

  EtatVoie getMostFrequent(List<EtatVoie> list) {
    Map<EtatVoie, int> countMap = {};
    int maxCount = 0;
    int embouteilleCount = 0;
    EtatVoie mostFrequent = EtatVoie.INCONNU;

    for (EtatVoie e in list) {
      countMap[e] = (countMap[e] ?? 0) + 1;
      if (e == EtatVoie.EMBOUTEILLE) {
        embouteilleCount++;
      }
    }

    if (countMap[EtatVoie.DENSE] != null) {
      mostFrequent = EtatVoie.DENSE;
      maxCount = countMap[EtatVoie.DENSE]!;
    } else if (embouteilleCount > maxCount) {
      mostFrequent = EtatVoie.EMBOUTEILLE;
      maxCount = embouteilleCount;
    } else {
      for (EtatVoie e in countMap.keys) {
        if (e != EtatVoie.EMBOUTEILLE && e != EtatVoie.DENSE && countMap[e]! > maxCount) {
          maxCount = countMap[e]!;
          mostFrequent = e;
        }
      }
    }

    return mostFrequent;
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

  Future<void> fetchAdresseFromSearch() async {
    try {
      var response = await client.get(Uri.parse('$baseUriApiGouv?q=${searchString.value}&postcode=33000'));

      var allData = json.decode(response.body) as Map<dynamic, dynamic>;

      for (var element in allData['features']) {
        print(allData);
        if(isInSquare(element['geometry']['coordinates'][0], element['geometry']['coordinates'][1])) {
          addressListSearch.add(SearchAdressModel.fromMap(element));
        }
      }

      startSearching.value = false;
    } catch (e) {
      print(e);
    }
  }

  void emptySearch(){
    searchString.value = "";
    addressListSearch.value.clear();
    listMarker.value.clear();
    placeSearchController.text = "";
  }


  @override
  onInit() async{
    super.onInit();
    await fetchAllData();
    await createPolylines();
    currentPosition.value = await determinePosition();

    placeSearchController.addListener(() {
      searchString.value = placeSearchController.text;
    });

    debounce(searchString, (_) async {
      addressListSearch.value.clear();
      if(searchString.value.isNotEmpty) startSearching.value = true;
      if(searchString.value.isEmpty) startSearching.value = false;
      if(searchString.value.length > 2) await fetchAdresseFromSearch();
      if(addressListSearch.value.isEmpty) emptyAfterSearch.value = true;
    }, time: const Duration(seconds: 1));
  }
}
