import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'package:utopian_rocks_mobile/models/model.dart';

class SteemApi {
  final Client _client = Client();

  static const String _url = 'https://steemit.com/@utopian-io.json';
  static double totalVp = 0;
  static SteemRequest req;
  static Duration dateTime;

  Future<void> getRequest() async {
    req = await _client
        .get(Uri.parse(_url))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => SteemRequest.fromJson(json["user"]));
  }

  double calculateVotingPower({String x}) {
    if (int.parse(x) % 120 == 0) {
      getRequest();
    }

    if (totalVp > 100.00) {
      return 100.00;
    } else {
      return totalVp;
    }
  }

  int getRechargeTime(int x) {
    if (dateTime == null || x % 120 == 0) {
      dateTime = DateTime.now().toUtc().difference(
            DateTime.parse(req.lastVoteTime),
          );
    }
    int counter = x % 120;

    double regenVP = ((dateTime.inSeconds * 10000) / 86400) / 5;
    totalVp = (req.votingPower + regenVP) / 100;

    double missingVp = (100.0 - totalVp);

    if (missingVp < 0) {
      return 0;
    } else {
      return (((missingVp * 432000) * 100 ~/ 10000) - counter).toInt();
    }
  }
}
