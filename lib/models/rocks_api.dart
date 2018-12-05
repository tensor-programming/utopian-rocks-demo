import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'package:utopian_rocks_mobile/models/model.dart';

class RocksApi {
  final Client _client = Client();

  static const String _url = 'https://utopian.rocks/api/posts?status={0}';

  Future<List<Contribution>> getContributions({
    String pageName = "unreviewed",
  }) async {
    List<Contribution> items = [];

    await _client
        .get(Uri.parse(_url.replaceFirst("{0}", pageName)))
        .then((result) => result.body)
        .then(json.decode)
        .then((json) => json.forEach((contribution) {
              Contribution con = Contribution.fromJson(contribution);
              if (con.status == pageName) {
                items.add(con);
              }
            }));

    return items;
  }
}
