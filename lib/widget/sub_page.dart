import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubPage extends StatelessWidget {
  final Color pageBackgroundColor;
  final String pageTitle;
  final String pageDescription;
  final double height;

  const SubPage({
    super.key,
    required this.pageBackgroundColor,
    required this.pageTitle,
    required this.pageDescription,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        // inner border color
        color: pageBackgroundColor,

        // outer border color
        border: Border.all(width: 2, color: pageBackgroundColor),

        // outer border shape
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title of the sub page
          Text(
            pageTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Description
          Text(
            pageDescription,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
