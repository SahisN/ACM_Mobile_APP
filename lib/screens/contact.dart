import 'package:acm_app/widgets/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:acm_app/data/social_media.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final social in socialMediaData)
            CategoryGridItem(
                title: social.title,
                cardColors: social.colors,
                imageLink: social.imageAssets)
        ],
      ),
    );
  }
}
