    // return SliverAppBar(
    //   toolbarHeight: 70,
    //   elevation: 0,
    //   floating: true,
    //   backgroundColor: Colors.transparent,
    //   centerTitle: true,
    //   title:
    //   Container(
    //     height: 35,
    //     width: 100,
    //   decoration: const BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage("lib/images/showanalytic_logo.png"),
    //         fit: BoxFit.cover),
    //   ),
    //   ),
    //   actions: [
    //     Column(
    //       children: [
    //         const SizedBox(height: 10),
    //         Builder(
    //           builder: ((context) {
    //             return IconButton(
    //               icon: const Icon(Icons.search),
    //               iconSize: 30,
    //               onPressed: () {
    //                 TextField(
    //     controller: queryController,
    //     decoration: InputDecoration(
    //         fillColor: Colors.white,
    //         filled: true,
    //         border: const OutlineInputBorder(),
    //         focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(10),
    //           borderSide: const BorderSide(color: Color(0xFF8F00FF)),
    //         ),
    //         hintText: 'Digite seu E-mail',
    //         hintStyle: Theme.of(context).textTheme.headline5));
    //               },
    //             );
    //           }),
    //         ),
    //       ],
    //     )
    //   ]);
import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget with PreferredSizeWidget{
  const CustomAppbar({ Key? key }) : super(key: key);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _CustomAppbarState extends State<CustomAppbar> {
  final TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
        return SliverAppBar(
      toolbarHeight: 70,
      elevation: 0,
      floating: true,
      backgroundColor: Colors.transparent,
      centerTitle: true,
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
                  onPressed: () {
                    TextField(
        controller: queryController,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF8F00FF)),
            ),
            hintText: 'Digite seu E-mail',
            hintStyle: Theme.of(context).textTheme.headline5));
                  },
                );
              }),
            ),
          ],
        )
      ]);
  }
}