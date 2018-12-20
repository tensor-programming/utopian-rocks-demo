import 'package:flutter/material.dart';

import 'package:utopian_rocks_mobile/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_mobile/utils.dart';

class BottomBar extends StatelessWidget {
  final ContributionBloc conBloc;

  BottomBar(this.conBloc);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xff26A69A),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12.0),
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
