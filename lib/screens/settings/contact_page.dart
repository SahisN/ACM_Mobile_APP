// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:acm_app/data/social_media.dart';
import 'package:acm_app/widget/social_media_grid_item.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        //iconTheme: Theme.of(context).iconTheme,
      ),
      body: GridView(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: socialMediaTypes
            .map(
              (social) => SocialMediaGridItem(
                bgColor: social.bgColor,
                imageLogo: social.imageLogo,
                url: social.url,
              ),
            )
            .toList(),
      ),
    );
  }
}
