import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:utopian_rocks_mobile/models/model.dart';
import 'package:utopian_rocks_mobile/models/rocks_api.dart';

class ContributionBloc {
  final RocksApi rocksApi;

  Stream<List<Contribution>> _results = Stream.empty();

  BehaviorSubject<String> _pageName =
      BehaviorSubject<String>(seedValue: 'unreviewed');

  // [pending, pending, pending, unreviewed, unreviewed, unreviewed] => pending, unreviewed

  Stream<List<Contribution>> get results => _results;

  Sink<String> get pageName => _pageName;

  ContributionBloc(this.rocksApi) {
    _results = _pageName
        .asyncMap((page) => rocksApi.getContributions(pageName: page))
        .asBroadcastStream();
  }

  void dispose() {
    _pageName.close();
  }
}
