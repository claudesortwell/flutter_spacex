import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../class/Launch.dart';

class LaunchesListView extends StatefulWidget {
  const LaunchesListView({super.key});

  @override
  _LaunchesListViewState createState() => _LaunchesListViewState();
}

/// Displays a list of Launchess.
class _LaunchesListViewState extends State<LaunchesListView> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX'),
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: FutureBuilder<List<Launch>>(
        builder: (context, projectSnap) {
          if (projectSnap.data == null) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return ListView.builder(
            itemCount: projectSnap.data!.length,
            itemBuilder: (context, index) {
              final launch = projectSnap.data![index];

              return ListTile(
                  title: Text(launch.name),
                  minVerticalPadding: 20,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        // Display the Flutter Logo image asset.
                        foregroundImage: launch.thumbImage != null
                            ? NetworkImage(launch.thumbImage!)
                            : null,
                      ),
                    ],
                  ),
                  subtitle: Text(
                      '${launch.launchDate != null ? DateFormat().format(launch.launchDate!.toLocal()) : 'Launch Date N/A'} \nStatus: ${launch.upcoming ? 'Upcoming' : launch.success ? 'Success' : 'Failure'}'),
                  onTap: () {
                    // Navigate to the details page. If the user leaves and returns to
                    // the app after it has been killed while running in the
                    // background, the navigation stack is restored.
                    Navigator.restorablePushNamed(context, '/launches',
                        arguments: {
                          "launch": jsonEncode(launch.toJson())
                              .replaceAll("/", HtmlEscape().convert("/"))
                              .toString()
                        });
                  });
            },
          );
        },
        future: _client.getAllLaunches(),
      ),

      // ).builder(
      //   // Providing a restorationId allows the ListView to restore the
      //   // scroll position when a user leaves and returns to the app after it
      //   // has been killed while running in the background.
      //   restorationId: 'sampleItemListView',
      //   itemCount: 0,
      //   itemBuilder: (BuildContext context, int index) {
      //     final item = items[index];

      //     return ListTile(
      //         title: Text('SampleItem ${item.id}'),
      //         leading: const CircleAvatar(
      //           // Display the Flutter Logo image asset.
      //           foregroundImage: AssetImage('assets/images/flutter_logo.png'),
      //         ),
      //         onTap: () {
      //           // Navigate to the details page. If the user leaves and returns to
      //           // the app after it has been killed while running in the
      //           // background, the navigation stack is restored.
      //           Navigator.restorablePushNamed(
      //             context,
      //             SampleItemDetailsView.routeName,
      //           );
      //         });
      //   },
      // ),
    );
  }
}
