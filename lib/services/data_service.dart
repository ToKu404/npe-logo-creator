import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<bool> takePicture(Uint8List image) async {
  try {
    await ImageGallerySaver.saveImage(
      image,
      quality: 100,
      name: 'logo',
    );
    return true;
  } catch (e) {
    return false;
  }
}

Future<Uint8List> captureWidget(BuildContext context) async {
  final box = context.findRenderObject() as RenderRepaintBoundary;
  final image = await box.toImage(pixelRatio: 4.0);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final bytes = byteData!.buffer.asUint8List();

  return bytes;
}


