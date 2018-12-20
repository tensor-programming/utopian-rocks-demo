import 'package:flutter/material.dart';

import 'package:utopian_rocks_mobile/models/model.dart';
import 'package:utopian_rocks_mobile/blocs/contribution_bloc.dart';

import 'package:utopian_rocks_mobile/utils.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  ListPage(this.pageName, this.bloc);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);

    return StreamBuilder(
        stream: bloc.filteredResults,
        builder:
            (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                int iconCode = getIcon(snapshot, index);
                String repo = checkRepo(snapshot, index);
                String timestamp = convertTimestamp(snapshot, index, pageName);
                Color categoryColor = getCategoryColor(snapshot, index);

                return GestureDetector(
                  onDoubleTap: () => launchUrl(snapshot.data[index].url),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              'https://steemitimages.com/u/${snapshot.data[index].author}/avatar',
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(
                      '${snapshot.data[index].title}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Text(
                      '$repo - $timestamp',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(
                      IconData(iconCode ?? 0x004e, fontFamily: 'Utopicons'),
                      color: categoryColor ?? Color(0xFFB10DC9),
                    ),
                  ),
                );
              });
        });
  }
}
