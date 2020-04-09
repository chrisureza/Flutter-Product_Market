import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backgroundHero(context),
          _loginForm(context),
        ],
      ),
    );
  }

  _backgroundHero(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final background = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        ),
      ),
    );
    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.1),
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        Positioned(top: 30.0, left: -30.0, child: circle),
        Positioned(top: -40.0, right: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle),
        Positioned(top: 70.0, right: 80.0, child: circle),
        Positioned(bottom: -50.0, left: 20.0, child: circle),
        SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
                SizedBox(
                  height: 10.0,
                  width: double.infinity,
                ),
                Text(
                  'Christian Ureña',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 200.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
