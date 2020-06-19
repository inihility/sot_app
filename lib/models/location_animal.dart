class LocationAnimal{
  final String id;
  final String name;
  
  factory LocationAnimal.fromMap(Map<String, dynamic> json) => new LocationAnimal(
    id: json["id"],
    name: json["name"]
  );

  LocationAnimal({this.id, this.name});
}