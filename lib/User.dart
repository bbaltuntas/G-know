import 'dart:core';

class User {
  String name;
  String login;
  String avatar_url;
  int followers;
  int following;
  String created_at;

  User(
      {this.name,
      this.login,
      this.avatar_url,
      this.followers,
      this.following,
      this.created_at});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json["name"],
        login: json["login"],
        avatar_url: json["avatar_url"],
        followers: json["followers"],
        following: json["following"],
        created_at: json["created_at"]);
  }
}
