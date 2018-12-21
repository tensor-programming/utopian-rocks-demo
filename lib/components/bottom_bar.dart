import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:utopian_rocks_mobile/blocs/base_provider.dart';
import 'package:utopian_rocks_mobile/blocs/steem_bloc.dart';

import 'package:utopian_rocks_mobile/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_mobile/utils.dart';

class BottomBar extends StatelessWidget {
  final ContributionBloc conBloc;

  BottomBar(this.conBloc);

  @override
  Widget build(BuildContext context) {
    final steemBloc = Provider.of<SteemBloc>(context);

    return BottomAppBar(
      color: Color(0xff26A69A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: steemBloc.timer,
            builder: (context, timerSnapshot) => Text(
                  'Next Vote Cycle: ${DateFormat.Hms().format(
                    DateTime(0, 0, 0, 0, 0, timerSnapshot.data ?? 0),
                  )}',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
          ),
          StreamBuilder(
              stream: steemBloc.voteCount,
              builder: (context, votecountSnapshot) {
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      'Vote Power: ${votecountSnapshot.data != 100.00 || null ? votecountSnapshot.data?.toStringAsPrecision(4) ?? 00.00 : 100.00}',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Icon(Icons.flash_on, size: 18.0)
                  ],
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: _generateMenu(categories, conBloc),
          )
        ],
      ),
    );
  }

  Widget _generateMenu(
    List<String> categories,
    ContributionBloc bloc,
  ) {
    return PopupMenuButton<String>(
      tooltip: 'Filter Contribution Categories',
      onSelected: (category) => bloc.filter.add(category),
      itemBuilder: (context) => categories
          .map((cat) => PopupMenuItem(
                height: 40.0,
                value: cat,
                child: ListTile(
                  leading: Icon(
                    IconData(
                      icons[cat],
                      fontFamily: 'Utopicons',
                    ),
                    color: colors[cat],
                  ),
                  title: Text(cat),
                ),
              ))
          .toList(),
    );
  }
}
