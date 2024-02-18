import 'package:acm_app/model/social_media_type.dart';
import 'package:flutter/material.dart';

final socialMediaTypes = [
  SocialMediaType(
    bgColor: [const Color.fromARGB(255, 9, 43, 99)],
    imageLogo: 'assets/images/acm_blob.png',
    url: 'https://acm-calstatela.com',
  ),
  SocialMediaType(
    bgColor: [Colors.indigo.shade700],
    imageLogo: 'assets/images/discord.png',
    url: 'https://discord.com/invite/wX58JRv',
  ),
  SocialMediaType(
    bgColor: [Colors.teal.shade400],
    imageLogo: 'assets/images/linkedin.png',
    url: 'https://www.linkedin.com/in/acm-cal-state-la-2a92b4260/',
  ),
  SocialMediaType(
    bgColor: [Colors.pink],
    imageLogo: 'assets/images/instagram.png',
    url: 'https://www.instagram.com/calstatela_acm/?hl=en',
  ),
  SocialMediaType(
    bgColor: [Colors.blue],
    imageLogo: 'assets/images/facebook.png',
    url: 'https://www.facebook.com/calstatela.acm',
  ),
  SocialMediaType(
      bgColor: [Colors.white],
      imageLogo: 'assets/images/gmail.png',
      url: 'mailto:acm.calstatela@gmail.com?subject=Greetings ACM!')
];
