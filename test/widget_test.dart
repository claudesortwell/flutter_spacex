// This is an example Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
//
// Visit https://flutter.dev/docs/cookbook/testing/widget/introduction for
// more information about Widget testing.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:new_flutter_template/src/class/launch.dart';
import 'package:new_flutter_template/src/launches_feature/launch_item_details_view.dart';

void main() {
  group('LaunchDetails', () {
    testWidgets('should display launch details', (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        // Build myWidget and trigger a frame.

        final launch = Launch.fromJson(jsonDecode(
            '{"name":"FalconSat","id":"5eb87cd9ffd86e000604b32a","launchDate":"2006-03-17T00:00:00.000Z","upcoming":false,"success":false,"thumbImage":"https:&#47;&#47;images2.imgbox.com&#47;94&#47;f2&#47;NN6Ph45r_o.png","bigImage":"https:&#47;&#47;images2.imgbox.com&#47;5b&#47;02&#47;QcxHUb5V_o.png","details":"Engine failure at 33 seconds and loss of vehicle","rocket":"5e9d0d95eda69955f709d1eb"}'
                .replaceAll(HtmlEscape().convert("/"), "/")));

        await tester.pumpWidget(
          MaterialApp(
              title: 'Flutter Demo',
              home: Scaffold(
                  appBar: AppBar(
                    title: Text('TEST'),
                  ),
                  body: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [LaunchData(launch: launch)])))),
        );

        expect(find.textContaining('FalconSat'), findsOneWidget);
        expect(
            find.textContaining(
                'Engine failure at 33 seconds and loss of vehicle'),
            findsOneWidget);
      });
    });
  });
}
