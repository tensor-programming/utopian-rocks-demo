import 'package:flutter/material.dart';

// import 'package:utopian_rocks/model/html_parser.dart';
import 'package:utopian_rocks/blocs/contribution_bloc.dart';
import 'package:utopian_rocks/model/model.dart';
import 'package:utopian_rocks/utils/utils.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String tabName;
  final Function(String, ContributionBloc) callback;

  ListPage(this.tabName, this.bloc, this.callback);
  // Pass in the [tabName] or string which represents the page name.
  // Based on the string passed in, the stream will get different contributions.

  @override
  Widget build(BuildContext context) {
    callback(tabName, bloc);

    // [StreamBuilder] auto-updates the data based on the incoming steam from the BLoC
    return StreamBuilder(
      stream: bloc.filteredResults,
      builder:
          (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
        // callback(bloc, context);
        // If stream hasn't presented data yet, show a [CircularProgressIndicator]
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // Generate [ListView] using the [AsyncSnapshot] from the [StreamBuilder]
        // [ListView] provides lazy loading and programmatically generates the Page.
        return Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Format the data using appropriate methods.
                    String repo = checkRepo(snapshot, index);
                    String created = convertTimestamp(snapshot, index, tabName);
                    Color categoryColor = getCategoryColor(snapshot, index);
                    int iconCode = getIcon(snapshot, index);

                    // A [GestureDetector] to allow the user to open the article in a browser window or share it.
                    return GestureDetector(
                      // [ListTile] is the main body for each Contribution
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                // Get user name and then get the avatar from steemitimages.com
                                image: NetworkImage(
                                  'https://steemitimages.com/u/${snapshot.data[index].author}/avatar',
                                ),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),

                        // Contribution Title with formated text.
                        title: Text(
                          '${snapshot.data[index].title}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        // Subtitle takes the repo name and formatted timestamp and displays them below Title
                        subtitle: Text(
                          "$repo - $created",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Get icon from utopicons font family and color it based on the category.
                        trailing: Icon(
                          IconData(iconCode ?? 0x0000, fontFamily: 'Utopicons'),
                          color: categoryColor,
                        ),
                      ),
                      // Using the [url_launch] library to deploy an intent on both android and iOS with the contribution url.
                      onDoubleTap: () {
                        launchUrl(snapshot.data[index].url);
                      },
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
