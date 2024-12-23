import 'package:acm_app/util/url_launcher.dart';
import 'package:flutter/material.dart';

class SocialMediaGridItem extends StatelessWidget {
  final List<Color> bgColor;
  final String imageLogo;
  final String url;

  const SocialMediaGridItem({
    super.key,
    required this.bgColor,
    required this.imageLogo,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LaunchUrl(url, context);
      },
      child: Card(
        color: bgColor.isNotEmpty ? bgColor[0] : Colors.transparent,
        child: Center(
          child: SizedBox(
            width: 90,
            height: 90,
            child: Image.asset(
              imageLogo,
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _launchURL(String url, context) async {
  //   /*
  //   if (await launchUrl(target)) {
  //     // throw "Could not launch $url";

  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Unable to load link'),
  //         duration: Duration(seconds: 5),
  //       ),
  //     );
  //   }
  //   */

  //   try {
  //     Uri target = Uri.parse(url);
  //     await launchUrl(target);
  //   } catch (_) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Unable to load link'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }
}
