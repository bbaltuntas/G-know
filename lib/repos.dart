class Repos {
  String name;

  Repos({this.name});

  Map toJson() {
    return {"name": name};
  }

  factory Repos.fromJson(Map<String, dynamic> json) {
    return Repos(
      name: json["name"],
    );
  }
}
