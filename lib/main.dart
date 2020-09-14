import 'package:flutter/material.dart';
import 'package:animal_rescue/screens/home/home_screen.dart';
import 'package:animal_rescue/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:animal_rescue/services/Authentication.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(bodyColor:(Colors.black)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Consumer(
              builder: (context, AuthService authService, _) {
                switch (authService.status) {
                  case AuthStatus.Authenticated:
                    return HomeScreen();
                  case AuthStatus.Unauthenticated:
                    return Login();
                }
              }
          ),
        )
    );
  }
}
