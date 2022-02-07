class Coord {
  const Coord({
    required this.lon,
    required this.lat,
  });
  final double lon;
  final double lat;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat']*1.0,
      lon: json['lon']*1.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon
    };
  }
}