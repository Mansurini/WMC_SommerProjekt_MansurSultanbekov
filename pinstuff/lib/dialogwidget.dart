// ignore: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'pininfo.dart';
import 'opengraphfetch.dart';
import 'pinapi.dart';

class AddPinDialog extends StatefulWidget {
  final String? initialUrl;

  const AddPinDialog({super.key, this.initialUrl});

  @override
  State<AddPinDialog> createState() => _AddPinDialogState();
}

class _AddPinDialogState extends State<AddPinDialog> {
  late TextEditingController urlController;
  String? previewImageUrl;
  bool loading = false;

 @override
  void initState() {
    super.initState();
    urlController = TextEditingController(text: widget.initialUrl ?? "");
  }
  

  Future<void> fetchPreview() async {
  setState(() => loading = true);
  try {
    final url = urlController.text;
    String? imageUrl;

if (RegExp(r"\.(png|jpg|jpeg|gif|webp)(\?.*)?$", caseSensitive: false)
    .hasMatch(url)) {
  imageUrl = url;
} else {
  imageUrl = await fetchOpenGraphImage(url);
}

previewImageUrl = imageUrl ?? "https://dummyimage.com/300x200";
    setState(() {
      previewImageUrl = imageUrl ?? "https://dummyimage.com/300x200";
      loading = false;
    });
  } catch (e) {
    setState(() {
      previewImageUrl = "https://dummyimage.com/300x200";
      loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Neuen Pin erstellen"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: urlController,
            decoration: InputDecoration(labelText: "Link eingeben"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: fetchPreview,
            child: Text("Vorschau laden"),
          ),
          if (loading) CircularProgressIndicator(),
          if (previewImageUrl != null)
            urlController.text.startsWith("http") 
            ? Image.network(previewImageUrl!) 
            : Image.file(File(previewImageUrl!)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Abbrechen"),
        ),
        ElevatedButton(
  onPressed: previewImageUrl == null
      ? null
      : () async {
          // Pin lokal erzeugen
          final newPin = PinInfo(
            imageUrl: previewImageUrl!,
            x: 200,
            y: 300,
          );
          // Pin automatisch ans Backend senden
          final dbSavedPin = await PinApi.addPin(newPin);

          // Dialog schließen und Pin an die Pinnwand zurückgeben
          Navigator.pop(context, dbSavedPin);

          
        },
  child: Text("Pin erstellen"),
),
      ],
    );
  }
}