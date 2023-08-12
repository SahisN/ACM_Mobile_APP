import 'package:acm_app/models/social_media_category.dart';
import 'package:flutter/material.dart';

final socialMediaData = [
  SocialMediaCategory(
    title: 'Instagram',
    colors: [Colors.pink, const Color.fromARGB(255, 242, 239, 240)],
    imageAssets: Image.asset('assets/images/instagram.png'),
  ),
  SocialMediaCategory(
    title: 'Discord',
    colors: [Colors.blue, Colors.deepPurpleAccent],
    imageAssets: Image.asset('assets/images/discord.png'),
  ),
  SocialMediaCategory(
    title: 'ACM Website',
    colors: [Colors.blue, Colors.blueAccent],
    imageAssets: Image.asset('assets/images/acm.png'),
  ),
  SocialMediaCategory(
    title: 'Facebook',
    colors: [Colors.deepPurple, Colors.blueAccent],
    imageAssets: Image.asset('assets/images/facebook.png'),
  ),
  SocialMediaCategory(
    title: 'LinkedIn',
    colors: [Colors.white, Colors.lightBlue],
    imageAssets: Image.asset('assets/images/linkedin.png'),
  ),
];
