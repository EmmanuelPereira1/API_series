import 'package:api_series/config/theme.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp(
        title: 'Show Analytic',
        theme: theme(),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      );
  }
}
