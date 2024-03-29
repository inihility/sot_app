class Island {
  final String id;
  final String name;
  final String type;
  final String coord_long;
  final int coord_lat;
  final String coord;
  final String region;
  final bool has_image;

  factory Island.fromMap(Map<String, dynamic> json) => new Island(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      coord_long: json["coord_long"],
      coord_lat: json["coord_lat"],
      coord: json["coord_long"] + json["coord_lat"].toString(),
      region: json["region"],
      has_image: json["has_image"] == 1);

  Island(
      {this.id,
      this.name,
      this.type,
      this.coord_long,
      this.coord_lat,
      this.coord,
      this.region,
      this.has_image});
}
