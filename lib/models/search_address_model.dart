class SearchAdressModel{
  final String name;
  final double latitude;
  final double longitude;

  SearchAdressModel({required this.name, required this.latitude, required this.longitude});

  factory SearchAdressModel.fromMap(Map data) {
    return SearchAdressModel(
      name: data['properties']['name'],
      latitude: data['geometry']['coordinates'][1],
      longitude: data['geometry']['coordinates'][0]
    );
  }
}