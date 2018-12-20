import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:utopian_rocks_mobile/models/model.dart';
import 'package:utopian_rocks_mobile/models/rocks_api.dart';

import 'package:utopian_rocks_mobile/utils.dart';

class ContributionBloc {
  final RocksApi rocksApi;

  Stream<List<Contribution>> _results = Stream.empty();
  Observable<List<Contribution>> _filteredResults = Observable.empty();

  BehaviorSubject<String> _pageName =
      BehaviorSubject<String>(seedValue: 'unreviewed');

  BehaviorSubject<String> _filter = BehaviorSubject<String>(seedValue: 'all');

  // [pending, pending, pending, unreviewed, unreviewed, unreviewed] => pending, unreviewed

  Stream<List<Contribution>> get results => _results;
  Stream<List<Contribution>> get filteredResults => _filteredResults;

  Sink<String> get pageName => _pageName;
  Sink<String> get filter => _filter;

  ContributionBloc(this.rocksApi) {
    _results = _pageName
        .asyncMap((page) => rocksApi.getContributions(pageName: page))
        .asBroadcastStream();

    _filteredResults = Observable.combineLatest2(_filter, _results, applyFilter)
        .asBroadcastStream();
  }

  void dispose() {
    _pageName.close();
    _filter.close();
  }
}
