import 'package:http/http.dart' as http;

class ReposApi {
  static final String url = 'https://api.github.com/';
  static final String client_id = '813e9e974c8aed0f6d58';
  static final String client_secret =
      'f0bddcc5f1d7a70c689320851ffcab5c9a6f3310';
  static final String query =
      "?client_id=${client_id}&client_secret=${client_secret}";

  static Future getRepos(String login) {
    var uri = url + "users/" + login + "/repos" + query;
    return http.get(Uri.encodeFull(uri));
  }
}
