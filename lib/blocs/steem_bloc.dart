import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:utopian_rocks_mobile/models/steem_api.dart';

class SteemBloc {
  final SteemApi api;

  StreamController<double> _voteCount = StreamController<double>();
  StreamController<int> _timer = StreamController<int>();

  Stream<double> get voteCount => _voteCount.stream;
  Stream<int> get timer => _timer.stream;

  SteemBloc(this.api) {
    _voteCount.sink.addStream(
      Observable.periodic(Duration(seconds: 1), (x) => x)
          .asyncMap((x) => api.calculateVotingPower(x))
          .asBroadcastStream(),
    );

    _timer.sink.addStream(
      Observable.periodic(Duration(seconds: 1), (x) => x)
          .asyncMap((x) => api.getRechargeTime(x))
          .asBroadcastStream(),
    );
  }

  void dispose() {
    _voteCount.close();
    _timer.close();
  }
}
