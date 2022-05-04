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
      leading: 
        Builder(
          builder: ((context) {
            return IconButton(
              icon: const Icon(Icons.align_horizontal_right),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
        ),
      // title:
      actions: [
        Column(
          children: [
            const SizedBox(height: 10),
            Builder(
              builder: ((context) {
                return IconButton(
                  icon: const Icon(Icons.search), iconSize: 30,
                  onPressed: () {},
                );
              }),
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
