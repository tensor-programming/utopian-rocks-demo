import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:package_info/package_info.dart';

import 'package:utopian_rocks_mobile/models/model.dart';
import 'package:utopian_rocks_mobile/models/github_api.dart';

class InformationBloc {
  final Future<PackageInfo> packageInfo;
  final GithubApi api;

  StreamController<PackageInfo> _infoStream = StreamController<PackageInfo>();
  Stream<GithubModel> _releases = Stream.empty();

  Stream<PackageInfo> get infoStream => _infoStream.stream;
  Stream<GithubModel> get releases => _releases;

  InformationBloc(this.packageInfo, this.api) {
    _releases = Observable.defer(
      () => Observable.fromFuture(api.getReleases()).asBroadcastStream(),
      reusable: true,
    );

    _infoStream.sink.addStream(Observable.defer(
      () => Observable.fromFuture(packageInfo).asBroadcastStream(),
      reusable: true,
    ));
  }

  void dispose() {
    _infoStream.close();
  }
}
