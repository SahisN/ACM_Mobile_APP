import 'package:acm_app/widget/sub_page.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About US'),
        actions: [
          // join acm button. Clicking this button will redirect user to ACM membership website
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Join ACM',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image here - make this into widget if this gets called multiple times
            Image.asset('assets/images/3d_acm_logo.png',
                width: 400, height: 290),

            // about us
            const SubPage(
                pageBackgroundColor: Colors.blue,
                pageTitle: 'About US',
                pageDescription: 'Short Description...',
                height: 220),

            // our purpose
            const SubPage(
                pageBackgroundColor: Colors.white,
                pageTitle: 'Our Purpose',
                pageDescription: 'Short Description',
                height: 200),

            // why join acm?
            const SubPage(
                pageBackgroundColor: Colors.blue,
                pageTitle: 'Why Join ACM?',
                pageDescription: 'Short Description',
                height: 200)

            // join acm
          ],
        ),
      ),
    );
  }
}
