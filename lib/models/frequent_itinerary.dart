class FrequentItinerary{
  final double latitude;
  final double longitude;

  FrequentItinerary({
    required this.latitude,
    required this.longitude
  });

  factory FrequentItinerary.fromMap(Map data) {
    return FrequentItinerary(
        latitude: data['latiude'],
        longitude: data['longitude']
    );
  }

  Map<String, dynamic> toJson() => {"latitude": latitude, "longitude": longitude};
}