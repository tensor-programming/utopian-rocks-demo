import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import 'package:utopian_rocks_mobile/models/model.dart';

const categories = [
  'ideas',
  'development',
  'bug-hunting',
  'translations',
  'graphics',
  'analysis',
  'documentation',
  'tutorials',
  'video-tutorials',
  'copywriting',
  'blog',
  'social',
  'anti-abuse',
  'all',
];

const icons = <String, int>{
  'ideas': 0x0049,
  'development': 0x0046,
  'bug-hunting': 0x0043,
  'translations': 0x004a,
  'graphics': 0x0045,
  'analysis': 0x0041,
  'documentation': 0x0047,
  'tutorials': 0x004b,
  'video-tutorials': 0x0048,
  'copywriting': 0x0044,
  'blog': 0x0042,
  'social': 0x004c,
  'anti-abuse': 0x0050,
  'all': 0x004e
};

const colors = <String, Color>{
  'ideas': Color(0xFF4DD39F),
  'development': Color(0xFF000000),
  'bug-hunting': Color(0xffdb524c),
  'translations': Color(0xffffcf26),
  'graphics': Color(0xfff8a700),
  'analysis': Color(0xff174265),
  'documentation': Color(0xffa0a0a0),
  'tutorials': Color(0xFF792a51),
  'video-tutorials': Color(0xFFec3424),
  'copywriting': Color(0xFF007f80),
  'blog': Color(0xff0275d8),
  'social': Color(0xff7bc0f5),
  'anti-abuse': Color(0xff800000),
  'all': Color(0xff3237c9),
};

Color getCategoryColor(AsyncSnapshot snapshot, int index) {
  return colors[snapshot.data[index].category];
}

int getIcon(AsyncSnapshot snapshot, int index) {
  return icons[snapshot.data[index].category];
}

String checkRepo(AsyncSnapshot snapshot, int index) {
  if (snapshot.data[index].repository != "") {
    return snapshot.data[index].repository;
  } else {
    return 'No Repository';
  }
}

String convertTimestamp(AsyncSnapshot snapshot, int index, String pageName) {
  if (pageName == 'unreviewed') {
    return "Created: ${timeago.format(DateTime.parse(snapshot.data[index].created))}";
  } else {
    return "Reviewed: ${timeago.format(DateTime.parse(snapshot.data[index].reviewDate))}";
  }
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

List<Contribution> applyFilter(
  String filter,
  List<Contribution> contributions,
) {
  if (filter != 'all') {
    return contributions.where((con) => con.category == filter).toList();
  }

  return contributions;
}
