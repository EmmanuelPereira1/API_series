import 'package:flutter/material.dart';

import '../request/show_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
              Color(0XFF101A26),
              Color(0XFF026873),
              Color(0xFF35F2DF)
            ])),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
          body: ShowsList(),
        ),
    );
  }
}