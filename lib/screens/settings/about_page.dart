import 'package:acm_app/util/url_launcher.dart';
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
            onPressed: () {
              LaunchUrl('https://acm-calstatela.com/membership', context);
            },
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
                pageBackgroundColor: Colors.white,
                pageTitle: 'About US',
                pageDescription:
                    "We are the Cal State LA chapter of the Association for Computing Machinery (ACM), the world's largest computing society dedicated to advancing computing as a science and profession. As the campus's largest computer science student organization, we bring together students with a shared passion for computing.",
                height: 220),

            // our purpose
            const SubPage(
                pageBackgroundColor: Colors.white,
                pageTitle: 'Our Purpose',
                pageDescription:
                    'Is to provide computer science knowledge and resources to students at Cal State LA, host programming workshops on projects and emerging technologies, and offer mentorship guidance. We also prepare members for the workforce with professional development workshops featuring guest speakers and alumni.',
                height: 200),
          ],
        ),
      ),
    );
  }
}
