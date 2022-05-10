import 'package:api_series/config/gradientbackground.dart';
import 'package:api_series/login/google_sign_in.dart';
import 'package:api_series/models/search_show_model.dart';
import 'package:api_series/models/show_model.dart';
import 'package:api_series/widgets/show_search_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../request/show_list.dart';
import '../widgets/search_appbar.dart';
import '../widgets/search_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    List<SearchShowModel> showListFromApi = [];
    return Container(
        decoration: GradientColor.gradient,
        child: Scaffold(
          drawer: Drawer(
              backgroundColor: Colors.transparent,
              child: Container(
                  decoration: GradientColor.gradient,
                  child: ListView(children: <Widget>[
                    DrawerHeader(
                        child: Image.asset(
                      'lib/images/showanalytic_logo.png',
                      width: 50,
                    )),
                    ListTile(
                      leading: const Icon(Icons.login, color: Colors.white),
                      title: const Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logoutGoogle();
                      },
                    ),
                  ]))),
          bottomNavigationBar: SnakeNavigationBar.color(
            backgroundColor:
                const Color.fromARGB(255, 0, 70, 78).withOpacity(0.8),
            snakeViewColor: const Color(0xFF03252D),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star, color: Colors.white),
                  label: 'my reviews'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.white),
                  label: 'profile'),
            ],
          ),
          backgroundColor: Colors.transparent,
          appBar: SearchAppbar(
            searchDelegate: ShowSearchDelegate(showList: showListFromApi),
          ),
          body: ShowsList(),
        ));
  }
}
