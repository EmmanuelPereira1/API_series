import 'package:api_series/widgets/custom_appbar.dart';
import 'package:api_series/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../request/show_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _drawerController = ZoomDrawerController();

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
      child: Scaffold(
        // drawer: CustomDrawer(),
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
              [const CustomAppBar()],
          body: ShowsList(),
        ),
      ),
    );
  }
}
