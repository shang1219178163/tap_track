# tap_track
a simple Tap-event global tracking package.

## Getting started
```dart
dependencies:
  tap_track: last_version
```

## Usage

```dart
import 'package:tap_track/tap_track.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    
    TapTrackManager.init(
        onReport: (params) {
            debugPrint("main onReport: $params");
        },
    );
    
    runApp(const MyApp());
}
```

```dart
TapTrackWidget(
  params: const {
    "event": "add",
    "goodsId": 9999,
  },
  child: FloatingActionButton(
    onPressed: () {
      debugPrint("$runtimeType onFloat");
      //flutter: main onReport: {event: add, goodsId: 9999}
    },
    child: const Icon(Icons.add),
  ),
);
```
