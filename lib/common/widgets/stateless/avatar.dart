import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? avatarUrl;
  final double sizeAvatar;
  const Avatar({
    Key? key,
    this.avatarUrl,
    this.sizeAvatar = 36,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeAvatar,
      height: sizeAvatar,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(sizeAvatar / 2),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: avatarUrl!,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
    // return
  }
}
