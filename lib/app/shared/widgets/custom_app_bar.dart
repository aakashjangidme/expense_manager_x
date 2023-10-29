import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onLeadingTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu), // You can use a custom icon here
          onPressed: onLeadingTap,
        ),
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              // Implement your search functionality here
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            minRadius: 16,
            maxRadius: 16,
            // You can set the image for the avatar here
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
