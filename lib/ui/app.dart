import 'package:flutter/material.dart';

import 'screens/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Flutter Reference Architecture App';

    return const MaterialApp(title: title, home: Home(title: title));
  }
}
