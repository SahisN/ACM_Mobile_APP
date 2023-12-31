import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  final List<Color> bgColor;
  final String imageLogo;
  final String url;

  const CategoryGridItem({
    Key? key,
    required this.bgColor,
    required this.imageLogo,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchURL(url);
      },
      child: Card(
        color: bgColor.isNotEmpty ? bgColor[0] : Colors.transparent,
        child: Center(
          child: SizedBox(
            width: 90,
            height: 90,
            child: Image.asset(imageLogo),
          ),
        ),
      ),
    );
  }
  Future<void> _launchURL(String url) async {
  Uri target = Uri.parse(url);
  if (!await launchUrl(target)) {
    throw "Could not launch $url";
  }
}
}