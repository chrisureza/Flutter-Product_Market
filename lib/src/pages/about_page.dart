import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  final titleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final subtitleStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        // centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          _imageSection(),
          _titleSection(),
          _descriptionSection(),
          _linksSection(),
          SizedBox(height: 40.0),
        ]),
      ),
    );
  }

  Widget _imageSection() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image(
          image: AssetImage('assets/Profile-Picture-(460x460).jpg'),
          height: 280.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _titleSection() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Text(
          "Hello! I'm Christian.",
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _descriptionSection() {
    final text =
        "This app was made for me to practice coding in Flutter and have them available for future references. \n\n"
        "The code for this app is public and you can find it at my personal Github.\n\n"
        "Below is the link to the repository and also a link to my personal website where you can take a look at some other of my projects, my personal life and my social media accounts.\n\n"
        "Hope you enjoyed this app and found it useful. Thanks for downloaded it! :D";
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: Text(
          text,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  _linksSection() {
    final repoLink = "https://github.com/chrisureza/Flutter-Product_Market";
    final websiteLink = "https://chrisureza.com/";

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Github Repository:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            InkWell(
              child: Text(
                repoLink,
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              onTap: () async {
                if (await canLaunch(repoLink)) {
                  await launch(repoLink);
                }
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Personal website:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            InkWell(
              child: Text(
                websiteLink,
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              onTap: () async {
                if (await canLaunch(websiteLink)) {
                  await launch(websiteLink);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
