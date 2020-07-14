import 'package:flutter/material.dart';
import 'detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'क्राउडसोर्स',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: new Detail(),
      // routes: {
      //   // "/login": (_) => new LoginPage(loginCallback:loginCallback, loginCallbackRegister:loginCallbackRegister),
      //   "/ui_access": (_) => new UiAccess(),
      //   // "/welcome": (_) => new WelcomePage2(loginCallback:loginCallback, loginCallbackRegister:loginCallbackRegister),
      //   "/intro": (_) => new IntroSlides(),
      //   // "/home": (_) => new HomePage(logoutCallback: logoutCallback),
      //   "/history": (_) => new HistoryPage(),
      //   "/historyNoLogin": (_) => new ProfileNoLogin(),
      // },
    );
  }
}
