import 'package:flutter/material.dart';
import 'package:form_validation_bloc/src/blocs/provider.dart';
import 'package:form_validation_bloc/src/providers/user_provider.dart';
import 'package:form_validation_bloc/src/utils/utils.dart';

class SignupPage extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backgroundHero(context),
          _singupForm(context),
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

  _singupForm(BuildContext context) {
    final bloc = Provider.of(context);
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
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 3.0),
                    spreadRadius: 2.0,
                  ),
                ]),
            child: Column(
              children: <Widget>[
                Text('Sign Up', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _emailField(bloc),
                SizedBox(height: 30.0),
                _passwordField(bloc),
                SizedBox(height: 30.0),
                _signupButton(bloc),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text('Do you have an account? Log in'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  _emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'example@email.com',
              labelText: 'Email Adress',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  _passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.deepPurple,
              ),
              labelText: 'Password',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  _signupButton(LoginBloc bloc) {
    //validFormStream
    return StreamBuilder(
      stream: bloc.validFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Sign Up'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _singup(context, bloc) : null,
        );
      },
    );
  }

  _singup(BuildContext context, LoginBloc bloc) async {
    final info = await userProvider.newUser(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, info['message']);
    }
  }
}
