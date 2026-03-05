import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PinInfo> pinnedPins = [];

  void pressedSettingsButton() {}

  void pressedAddPinButton() {
    pinItem(
      Container(height: 100, width: 100, color: Colors.orange),
      200.0,
      300.0,
    );
  }

  void pinItem(Widget widget, double x, double y) {
    setState(() {
      pinnedWidgets.add(
        Positioned(
          left: x,
          top: y,
          child: pinnedWidgets.map((item) {
    return Positioned(
      left: item.x,
      top: item.y,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            item.x += details.delta.dx;
            item.y += details.delta.dy;
          });
        },
        child: item.widget,
      ),
    );
  }).toList(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: .fromRGBO(0, 0, 0, 0),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        actions: [
          IconButton(
            onPressed: pressedAddPinButton,
            icon: Icon(Icons.add),
            color: Colors.black,
            iconSize: 40.0,
          ),
          IconButton(
            onPressed: pressedSettingsButton,
            icon: Icon(Icons.settings),
            color: Colors.black,
            iconSize: 40.0,
          ),
        ],
      ),
      body: Stack(children: pinnedWidgets),
    );
  }
}
