class Repos {
  String name;

  Repos({this.name});

  Map toJson() {
    return {"name": name};
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    return map;
  }

  factory Repos.fromJson(Map<String, dynamic> json) {
    return Repos(
      name: json["name"],
    );
  }
}
