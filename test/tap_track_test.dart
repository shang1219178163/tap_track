import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tap_track/tap_track.dart';

void main() {
  test('tap', () {
    TapTrackWidget(
      data: const {
        "event": "tap",
        "goodsId": 1001,
      },
      child: ElevatedButton(
        onPressed: () {
          print("tap");
        },
        child: Text("tap"),
      ),
    );
  });
}
