import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:utopian_rocks/model/model.dart';
import 'package:utopian_rocks/model/repository.dart';
// import 'package:utopian_rocks/model/html_parser.dart';
import 'package:utopian_rocks/model/steem_api.dart';
import 'package:utopian_rocks/utils/utils.dart';

// Contribution buisness logic class
class ContributionBloc {
  final Api api;
  // final ParseWebsite parseWebsite;
  final SteemApi steemApi;

  // setup an empty streams for results, filteredResults, voteCount and timer.
  Stream<List<Contribution>> _results = Stream.empty();
  Observable<List<Contribution>> _filteredResults = Observable.empty();
  Stream<String> _voteCount = Stream.empty();
  Stream<int> _timer = Stream.empty();

  // BehaviorSubject allows seeding the tabIndex data to unreviewed.
  // Tagname is the name of the tab and modifier for the contributions
  BehaviorSubject<String> _tabName =
      BehaviorSubject<String>(seedValue: 'unreviewed');
  // BehaviorSubject for the filter, seeded to 'all' by default.
  BehaviorSubject<String> _filter = BehaviorSubject<String>(seedValue: 'all');

  // getters for the streams.
  Stream<List<Contribution>> get results => _results;
  Stream<List<Contribution>> get filteredResults => _filteredResults;
  Stream<String> get voteCount => _voteCount;
  Stream<int> get timer => _timer;

  // getters for the sinks.
  Sink<String> get tabName => _tabName;
  Sink<String> get filter => _filter;

  ContributionBloc(this.api, this.steemApi) {
    // get results by putting a new tabname into the tabname [Sink]
    _results = _tabName
        // Apply the api updateContributions function to tabIndex stream to get results.
        .asyncMap((tab) => api.updateContributions(tabName: tab))
        .asBroadcastStream();
    // Combine the Filter Sink and the results stream with the ApplyFilter to create a filtered list of Contributions.
    _filteredResults = Observable.combineLatest2(_filter, _results, applyFilter)
        .asBroadcastStream();

    // calculate voting power and correct every 5 seconds.
    _voteCount = Observable.periodic(
      Duration(seconds: 1),
      (x) => x.toString(),
    )
        .asyncMap(
          (s) => steemApi.calculateVotingPower(x: s),
        )
        .asBroadcastStream();

    // increment timer by emitting stream every second. Combines voting power and a periodic observable.
    _timer = Observable.combineLatest2(
        _voteCount,
        Observable.periodic(
          Duration(seconds: 1),
          (x) => x,
        ),
        (x, y) => steemApi.getRechargeTime(x, y)).asBroadcastStream();
  }

  void dispose() {
    _tabName.close();
    _filter.close();
  }
}
