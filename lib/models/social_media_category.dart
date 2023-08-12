import 'package:flutter/material.dart';

class SocialMediaCategory {
  SocialMediaCategory({
    required this.title,
    required this.colors,
    required this.imageAssets,
  });

  String title;
  List<Color> colors;
  Widget imageAssets;
}
