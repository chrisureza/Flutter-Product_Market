import 'package:flutter/material.dart';
import 'package:form_validation_bloc/src/blocs/provider.dart';
import 'package:form_validation_bloc/src/pages/about_page.dart';
import 'package:form_validation_bloc/src/pages/home_page.dart';
import 'package:form_validation_bloc/src/pages/login_page.dart';
import 'package:form_validation_bloc/src/pages/product_page.dart';
import 'package:form_validation_bloc/src/pages/signup_page.dart';
import 'package:form_validation_bloc/src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _prefs = new UserPreferences();
  await _prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = new UserPreferences();
    print(_prefs.token);

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'signup': (BuildContext context) => SignupPage(),
          'home': (BuildContext context) => HomePage(),
          'product': (BuildContext context) => ProductPage(),
          'about': (BuildContext context) => AboutPage(),
        },
        theme: ThemeData(primaryColor: Colors.deepPurple),
      ),
    );
  }
}
