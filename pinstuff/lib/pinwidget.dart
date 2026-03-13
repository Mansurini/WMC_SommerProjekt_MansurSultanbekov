import 'dart:io';

import 'package:flutter/material.dart';
import 'pininfo.dart';

class PinWidget extends StatefulWidget {
  final PinInfo pin;
  final VoidCallback onBringToFront;

  const PinWidget({super.key, required this.pin, required this.onBringToFront});

  @override
  State<PinWidget> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.pin.x,
      top: widget.pin.y,
      child: GestureDetector(
        onDoubleTap: () {
    setState(() {
      widget.onBringToFront();
    });
  },
        onPanUpdate: (details) {
          setState(() {
            widget.pin.x += details.delta.dx;
            widget.pin.y += details.delta.dy;
          });
        },
        child: Container(
          
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
    widget.pin.imageUrl.startsWith("http")
      ? Image.network(widget.pin.imageUrl, fit: BoxFit.cover)
      : Image.file(File(widget.pin.imageUrl), fit: BoxFit.cover),
  ],
          ),
        ),
      ),
    );
  }
}