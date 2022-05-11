import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        toolbarHeight: 70,
        elevation: 0,
        floating: true,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Container(
          height: 35,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/images/showanalytic_logo.png"),
                fit: BoxFit.cover),
          ),
        ),
);
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
