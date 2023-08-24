import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../class/launch.dart';
import '../class/rocket.dart';

class LaunchesDetailsView extends StatefulWidget {
  const LaunchesDetailsView({super.key});

  @override
  _LaunchesDetailsViewState createState() => _LaunchesDetailsViewState();
}

/// Displays detailed information about a Launches.
class _LaunchesDetailsViewState extends State<LaunchesDetailsView> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final launch = Launch.fromJson(
        jsonDecode(args['launch']!.replaceAll(HtmlEscape().convert("/"), "/")));

    return Scaffold(
      appBar: AppBar(
        title: Text(launch.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LaunchData(launch: launch),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Row(children: [
                Text("Rocket Info",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ]),
              const Padding(padding: EdgeInsets.only(top: 20)),
              (launch.rocket != null
                  ? FutureBuilder<Rocket>(
                      builder: (context, projectSnap) {
                        if (projectSnap.data == null) {
                          return const SizedBox(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return Column(
                          children: [
                            Row(children: [
                              const Text("Name"),
                              const Spacer(),
                              Text(projectSnap.data?.name ?? '')
                            ]),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Row(children: [
                              const Text("Country"),
                              const Spacer(),
                              Text(projectSnap.data?.country ?? '')
                            ]),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Row(children: [
                              const Text("Manufacter"),
                              const Spacer(),
                              Text(projectSnap.data?.company ?? '')
                            ]),
                          ],
                        );
                      },
                      future: _client.getARocket(launch.rocket!),
                    )
                  : const Text(''))
            ],
          ),
        ),
      ),
    );
  }
}

class LaunchData extends StatelessWidget {
  final Launch launch;

  const LaunchData({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
          child: launch.bigImage != null
              ? Image.network(
                  launch.bigImage!,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                )
              : const Text('')),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(children: [const Text("Name"), const Spacer(), Text(launch.name)]),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(children: [
        const Text("Launch Date"),
        const Spacer(),
        Text(launch.launchDate != null
            ? DateFormat().format(launch.launchDate!.toLocal())
            : 'N/A')
      ]),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(children: [
        const Text("Status"),
        const Spacer(),
        Text(launch.upcoming
            ? 'Upcoming'
            : launch.success
                ? 'Success'
                : 'Failure')
      ]),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(children: [Flexible(child: Text(launch.details ?? ''))]),
    ]);
  }
}
