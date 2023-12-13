import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage(
      {Key? key,
      this.imageUrl,
      this.file,
      required this.tag,
      required this.isFile})
      : super(key: key);
  final String? imageUrl;
  final String tag;
  final bool isFile;
  final XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
            isFile
                ? GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Hero(
                        tag: tag,
                        child: Image.file(File(file!.path), fit: BoxFit.cover)),
                  )
                : GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Hero(
                      tag: tag,
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                        imageUrl: imageUrl!,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
