import 'dart:io';

import 'package:flutter/material.dart';
import 'pininfo.dart';
import 'pinwidget.dart';
import 'dialogwidget.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:path/path.dart' as p;

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
  List<PinInfo> pinnedPins = []; //mach klasse noch!!!!! vergisss es nicht zukunfst ich

  void pressedSettingsButton() {
    throw UnimplementedError();
  }

void pressedAddPinButton() async {
  final result = await showDialog<PinInfo>(
    context: context,
    builder: (context) => AddPinDialog(),
  );

  if (result != null) {
    setState(() {
      pinnedPins.add(result);
    });
  }
}


// Hilfsfunktion zum Kopieren der Datei
String copyToAppFolder(String path) {
  final appDir = Directory('${Directory.current.path}/pinned_images');
  if (!appDir.existsSync()) appDir.createSync(recursive: true);

  final fileName = p.basename(path);
  final newPath = '${appDir.path}/$fileName';
  File(path).copySync(newPath);
  return newPath;
}

// Drop-Funktion
void dropLink(details) async {
  for (final file in details.files) {
    final path = file.path;

    if (path.endsWith('.png') || path.endsWith('.jpg') || path.endsWith('.jpeg') || path.endsWith('.gif')) {
      // Kopieren in permanenten Ordner
      final permanentPath = copyToAppFolder(path);

      final result = await showDialog<PinInfo>(
        context: context,
        builder: (context) => AddPinDialog(initialUrl: permanentPath),
      );

      if (result != null) {
        setState(() {
          pinnedPins.add(result);
        });
      }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: .fromRGBO(0, 0, 0, 0),
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
      body: DropTarget(
  onDragDone: dropLink,
  child: Stack(
    children: pinnedPins.map((pin) {
      return PinWidget(
        pin: pin,
        onBringToFront: () {
          setState(() {
            pinnedPins.remove(pin);
            pinnedPins.add(pin);
          });
        },
      );
    }).toList(),
  ),
),
    );
  }
}