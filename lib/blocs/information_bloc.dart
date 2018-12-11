import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:package_info/package_info.dart';

import 'package:utopian_rocks/model/github_api.dart';
import 'package:utopian_rocks/model/model.dart';

class InformationBloc {
  Future<PackageInfo> packageInfo;
  GithubApi api;

  // Package info stream
  Stream<PackageInfo> _infoStream = Stream.empty();
  Stream<GithubReleaseModel> _releases = Stream.empty();

  Stream<PackageInfo> get infoStream => _infoStream;
  Stream<GithubReleaseModel> get releases => _releases;

  // BLoc that serves package information to the information drawer.
  // Bloc gets Github release information only on application start.
  InformationBloc(this.packageInfo, this.api) {
    // Serve the [PackageInformation] using a defer observable which can only be subscribed to once.
    // This defer observable is re-created when the drawer opens.
    _infoStream = Observable.defer(
      () => Observable.fromFuture(packageInfo).asBroadcastStream(),
      reusable: true,
    );
    // release information is served as a defered Observable which can only be subscribed to once.
    // This stream also only has one element in it. This is done to stop from overflowing the Github API.
    // This defer observable is re-created on every button press.
    _releases = Observable.defer(
      () => Observable.fromFuture(api.getReleases()).asBroadcastStream(),
      reusable: true,
    );
  }
}
