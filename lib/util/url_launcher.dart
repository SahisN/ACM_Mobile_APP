import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> LaunchUrl(String url, context) async {
  try {
    Uri target = Uri.parse(url);
    await launchUrl(target);
  } catch (_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unable to load link'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
