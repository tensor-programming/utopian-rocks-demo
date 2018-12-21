import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:utopian_rocks_mobile/models/steem_api.dart';

class SteemBloc {
  final SteemApi api;

  StreamController<double> _voteCount = StreamController<double>();
  Stream<int> _timer = Stream.empty();

  Stream<double> get voteCount => _voteCount.stream;
  Stream<int> get timer => _timer;

  SteemBloc(this.api) {
    _voteCount.sink.addStream(
      Observable.periodic(Duration(seconds: 1), (x) => x)
          .asyncMap((x) => api.calculateVotingPower(x: x.toString())),
    );

    _timer = Observable.periodic(Duration(seconds: 1), (x) => x)
        .asyncMap((x) => api.getRechargeTime(x));
  }

  void dispose() {
    _voteCount.close();
  }
}
