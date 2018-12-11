import 'package:flutter/material.dart';

import 'package:utopian_rocks/utils/utils.dart';

import 'package:utopian_rocks/providers/information_provider.dart';

class InformationDrawer extends StatelessWidget {
  final AsyncSnapshot infoStreamSnapshot;

  InformationDrawer(this.infoStreamSnapshot);

  @override
  Widget build(BuildContext context) {
    // Create the informatino drawer based on the [infoStreamSnapshot]
    return Drawer(
      semanticLabel: 'Information Drawer',
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          // Build the info panel
          _buildInfoPanel(context),
          Center(
            child: Image.asset('assets/images/utopian-icon.png'),
          ),
        ],
      ),
    );
  }

  // create the info panel
  Widget _buildInfoPanel(BuildContext context) {
    if (!infoStreamSnapshot.hasData) {
      return Flexible(
        child: CircularProgressIndicator(),
      );
    }
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30.0),
          // expand the panel to the entire size of the screen width
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Information',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // create all of the info boxes using [_buildInfoTile]
        _buildInfoTile(
          '${infoStreamSnapshot.data.appName}',
          subtitle:
              "Pre-release Version Number: ${infoStreamSnapshot.data.version}",
        ),
        _buildInfoTile(
          'Instructions: ',
          subtitle: 'Double tab on a contribution to open it in a Browser',
        ),
        _buildInfoTile(
          'Author & Application Info',
          subtitle:
              'Developed by @Tensor. Many thanks to @Amosbastian for creating the original website: utopian.rocks and to the folks over at utopian.io',
        ),
        // Create button for checking to see if the application can be updated.
        RaisedButton(
          child: Text('Check for Update'),
          onPressed: () => _getNewRelease(context),
        ),
      ],
    );
  }

  // build generic listTiles for the info tiles.  [subtitle] is optional.
  Widget _buildInfoTile(String title, {String subtitle}) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle ?? '',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  // function to check if a new release is available.
  _getNewRelease(BuildContext context) {
    final informationBloc = InformationProvider.of(context);
    // listen to the releases stream to get the github release json
    informationBloc.releases.listen((releases) {
      // check tagname against the application version number
      if (infoStreamSnapshot.data.version.toString() != releases.tagName) {
        // create a dialog window for downloading the new update
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('${infoStreamSnapshot.data.appName}'),
                  content: Container(
                    child: Text(
                        'A new version of this application is available to download. The current version is ${infoStreamSnapshot.data.version} and the new version is ${releases.tagName}'),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Download'),
                      onPressed: () => launchUrl(releases.htmlUrl),
                    ),
                    FlatButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ));
      } else {
        // tell the user that there is no new release
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('${infoStreamSnapshot.data.appName}'),
                  content: Container(
                    child: Text('There is no new version at this time'),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ));
      }
    });
  }
}
