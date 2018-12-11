import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'package:utopian_rocks/model/model.dart';

class SteemApi {
  final Client _client = Client();
  static const String _url = 'https://steemit.com/@utopian-io.json';
  static SteemRequest request;

  Future<SteemRequest> getData() async {
    return await _client
        .get(Uri.parse(_url))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => SteemRequest.fromJson(json["user"]));
  }

  Future<String> calculateVotingPower({String x}) async {
    if (request == null) {
      request = await getData();
    } else if (int.parse(x ?? "0") % 5 == 0) {
      request = await getData();
    }

    Duration dateTime = DateTime.now().toUtc().difference(
          DateTime.parse(request.lastVoteTime),
        );

    double regeneratedVp = dateTime.inSeconds * 10000 / 86400 / 5;
    double totalVp = (request.votingPower + regeneratedVp) / 100;

    if (totalVp > 100.00) {
      return 100.00.toStringAsPrecision(5);
    } else {
      return totalVp.toStringAsPrecision(4);
    }
  }

  int getRechargeTime(String vp, int x) {
    double missingVp = (100.0 - double.parse(vp));

    if (missingVp < 0) {
      return 0;
    } else {
      return ((missingVp * 43.2 ~/ 0.01).toInt() - x);
    }
  }
}
