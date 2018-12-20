import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

import 'package:utopian_rocks_mobile/models/model.dart';

class GithubApi {
  final Client _client = Client();
  static const String _url =
      'https://api.github.com/repos/tensor-programming/utopian-rocks-mobile/releases';

  Future<GithubModel> getReleases() async {
    String resBody =
        await _client.get(Uri.parse(_url)).then((Response res) => res.body);
    List ghJson = json.decode(resBody);
    var x = ghJson.map((gh) => GithubModel.fromJson(gh)).toList();
    return x.first;
  }
}
