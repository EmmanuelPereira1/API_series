import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 60,
      elevation: 0,
      floating: true,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      // leading: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           SizedBox(height: 20),
      //           Row(
      //             children: [
      //               SizedBox(width: 20),
      //               Icon(
      //                 Icons.menu,
      //                 color: Colors.white,
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      title:
      Container(
        height: 35,
        width: 100,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("lib/images/showanalytic_logo.png"),
            fit: BoxFit.cover),
      ),
      ),
      actions: [
        Column(
          children: [
            const SizedBox(height: 10),
            Builder(
              builder: ((context) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                  onPressed: () {},
                );
              }),
            ),
          ],
        )
      ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

