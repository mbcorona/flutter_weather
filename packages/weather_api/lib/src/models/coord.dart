class Coord {
  const Coord({
    required this.lon,
    required this.lat,
  });
  final double lon;
  final double lat;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}