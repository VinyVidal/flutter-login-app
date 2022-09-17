import 'package:flutter/material.dart';
import 'package:login/routes.dart';

void main() {
  runApp(const App(key: Key('app')));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes(),
      initialRoute: '/',
    );
  }
}
