import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'package:utopian_rocks_mobile/models/model.dart';

class SteemApi {
  final Client _client = Client();

  static const String _url = 'https://steemit.com/@utopian-io.json';

  static double totalVp;
  static SteemResponse resp;
  static Duration dateTime;

  Future<void> getResponse() async {
    resp = await _client
        .get(Uri.parse(_url))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => SteemResponse.fromJson(json["user"]));
  }

  double calculateVotingPower(int x) {
    if (x % 30 == 0) {
      getResponse();
    }

    if (totalVp > 100.00) {
      return 100.00;
    } else {
      return totalVp;
    }
  }

  int getRechargeTime(int x) {
    if (dateTime == null || x % 30 == 0) {
      dateTime = DateTime.now().toUtc().difference(
            DateTime.parse(resp.lastVoteTime),
          );
    }

    int counter = x % 30;

    double regenVP = ((dateTime.inSeconds * 10000) / 86400) / 5;
    totalVp = (resp.votingPower + regenVP) / 100;

    double missingVp = (100.0 - totalVp);

    if (missingVp < 0) {
      return 0;
    } else {
      return (((missingVp * 432000) * 100 ~/ 10000) - counter).toInt();
    }
  }

  //10 hours = 864000 sec
}
