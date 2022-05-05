import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../request/show_list.dart';
import '../widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
              Color(0XFF101A26),
              Color(0XFF026873),
              Color(0xFF35F2DF)
            ])),
      ),
      SafeArea(
          child: Container(
        width: 200.0,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawerHeader(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/images/showanalytic_logo.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 1, 48, 53),
                    size: 30,
                  ),
                  title: Text("HOME",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 1, 48, 53),
                    size: 30,
                  ),
                  title: Text("PROFILE",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 1, 48, 53),
                    size: 30,
                  ),
                  title: Text("MY REVIEWS",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ))
          ],
        ),
      )),
      TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: const Duration(milliseconds: 500),
          builder: (_, double val, __) {
            return (Transform(
                // alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
                child: Container(
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
                        body: const ShowsList(),
                      )),
                )));
          }),
      GestureDetector(
        onTap: () {
          setState(() {
            value == 0 ? value = 1 : value = 0;
          });
        },
      )
    ]));
  }
}
