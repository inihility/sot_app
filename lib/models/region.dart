class Region{
  final String id;
  final String name;
  
  factory Region.fromMap(Map<String, dynamic> json) => new Region(
    id: json["id"],
    name: json["name"]
  );

  Region({this.id, this.name});
}