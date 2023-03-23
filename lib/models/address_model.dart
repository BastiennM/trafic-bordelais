import 'package:latlong2/latlong.dart';
import 'package:trafic_bordeaux/core/constants/enums.dart';

class AddressModel {
  final int id;
  final String typeVoie;
  final List<dynamic> coordinates;
  final String etat;


  AddressModel(
      {required this.id,
        required this.typeVoie,
        required this.coordinates,
        required this.etat
      });

  factory AddressModel.fromMap(Map data) {
    return AddressModel(
      id: data['properties']['gid'],
      typeVoie: data['properties']['typevoie'] ?? '',
      coordinates: data['geometry']['coordinates'] ?? [LatLng(0,0)],
      etat: data['properties']['etat'] ?? '',
    );
  }
}