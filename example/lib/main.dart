import 'package:flutter/material.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() {
    return TapTrackWidget(
      params: const {
        "event": "add",
        "goodsId": 9999,
      },
      child: FloatingActionButton(
        onPressed: () {
          debugPrint("$runtimeType onFloat");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    final items = <(String, VoidCallback)>[
      ("Tap", onTap),
      ("Buy", onBuy),
      ("Collect", onCollect),
    ];

    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              buildWrap<(String, VoidCallback)>(
                items: items,
                itemBuilder: (e) {
                  return TapTrackWidget(
                    params: {
                      "event": e.$1,
                      "goodsId": 1001,
                    },
                    child: ElevatedButton(
                      onPressed: e.$2,
                      child: Text(e.$1),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWrap<T>({
    required List items,
    required Widget Function(T e) itemBuilder,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        const runSpacing = 8.0;
        const rowCount = 4.0;
        final itemWidth = (constraints.maxWidth - spacing * (rowCount - 1)) / rowCount;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: [
            ...items.map(
              (e) {
                return Container(
                  width: itemWidth.truncateToDouble(),
                  height: itemWidth * 0.5,
                  decoration: const BoxDecoration(
                    // border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: itemBuilder(e),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void onTap() {
    debugPrint("$runtimeType onTap");
  }

  void onBuy() {
    debugPrint("$runtimeType onBuy");
  }

  void onCollect() {
    debugPrint("$runtimeType onCollect");
  }
}
