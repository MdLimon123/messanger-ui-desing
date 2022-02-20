import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.url,
    required this.radius,
    required this.onTab
  }) :
        super(key: key);

 const Avatar.small({
    Key? key,
    required this.url,
   required this.onTab

}): radius = 16,
   super(key: key);

  const Avatar.medium({
    Key? key,
    required this.url,
    required this.onTab

  }): radius = 22,
        super(key: key);

  const Avatar.large({
    Key? key,
    required this.url,
    required this.onTab

  }): radius = 34,
        super(key: key);

 final double radius;
 final String? url;
 final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(url!),
      backgroundColor:Theme.of(context).cardColor,
    );
  }
}
