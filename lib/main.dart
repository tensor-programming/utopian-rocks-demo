import 'package:flutter/material.dart';

import 'package:utopian_rocks_mobile/models/model.dart';
import 'package:utopian_rocks_mobile/models/rocks_api.dart';
import 'package:utopian_rocks_mobile/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_mobile/providers/contribution_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContributionProvider(
      contributionBloc: ContributionBloc(
        RocksApi(),
      ),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final contributionBloc = ContributionProvider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utopian Rocks Mobile',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Utopian Rocks Mobile',
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.rate_review),
                  text: 'Waiting for Review',
                ),
                Tab(
                  icon: Icon(Icons.hourglass_empty),
                  text: 'Waiting on Upvote',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage('unreviewed', contributionBloc),
              ListPage('pending', contributionBloc),
            ],
          ),
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  ListPage(this.pageName, this.bloc);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);

    return StreamBuilder(
        stream: bloc.results,
        builder:
            (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text('${snapshot.data[index].title}'),
                ),
          );
        });
  }
}
