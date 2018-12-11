import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:utopian_rocks/blocs/contribution_bloc.dart';
import 'package:utopian_rocks/utils/utils.dart';

class BottomSheetbar extends StatelessWidget {
  final ContributionBloc contributionBloc;

  BottomSheetbar(this.contributionBloc);

  @override
  Widget build(BuildContext context) {
    // Build the [BottomAppBar] based on the voteCount stream
    return BottomAppBar(
        color: Color(0xff26A69A),
        child: Row(
          children: [
            // Build the first [Text] based on the timer stream
            StreamBuilder(
                stream: contributionBloc.timer,
                builder: (context, timerSnapshot) {
                  // use intl to parse the amount of seconds with [DateTime] into a [DateFormat]
                  return Text(
                    'Next Vote Cycle: ${DateFormat.Hms().format(DateTime(0, 0, 0, 0, 0, timerSnapshot.data ?? 0))}',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  );
                }),
            StreamBuilder(
                stream: contributionBloc.voteCount,
                builder: (context, votecountSnapshot) {
                  return Text(
                    'Vote Power: ${votecountSnapshot.data != '100.00' || null ? double.parse(votecountSnapshot.data ?? '0').toStringAsPrecision(4) : 100.00}',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  );
                }),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              // Create Filter menu on bottom right
              child: _generateMenu(categories, contributionBloc),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
        ));
  }

  Widget _generateMenu(
    List<String> categories,
    ContributionBloc bloc,
  ) {
    return PopupMenuButton<String>(
      tooltip: 'Filter Contribution Categories',
      // When fitler selected add it to the filter [Sink]
      onSelected: (category) => bloc.filter.add(category),
      // Map through all of the categories and then programmatically create the menu items.
      itemBuilder: (context) => categories
          .map((cate) => PopupMenuItem(
                height: 40.0,
                value: cate,
                child: ListTile(
                  leading: Icon(
                    IconData(
                      icons[cate],
                      fontFamily: 'Utopicons',
                    ),
                    color: colors[cate],
                  ),
                  title: Text(cate),
                ),
              ))
          .toList(),
    );
  }
}
