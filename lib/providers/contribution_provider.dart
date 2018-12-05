import 'package:flutter/widgets.dart';

import 'package:utopian_rocks_mobile/models/rocks_api.dart';
import 'package:utopian_rocks_mobile/blocs/contribution_bloc.dart';

class ContributionProvider extends InheritedWidget {
  final ContributionBloc contributionBloc;

  @override
  updateShouldNotify(InheritedWidget oldwidget) => true;

  static ContributionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ContributionProvider)
              as ContributionProvider)
          .contributionBloc;

  ContributionProvider({
    Key key,
    ContributionBloc contributionBloc,
    Widget child,
  })  : this.contributionBloc = contributionBloc ??
            ContributionBloc(
              RocksApi(),
            ),
        super(child: child, key: key);
}
