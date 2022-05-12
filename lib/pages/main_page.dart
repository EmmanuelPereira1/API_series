// // import 'package:api_series/config/gradientbackground.dart';
// // import 'package:api_series/login/google_sign_in.dart';
// // import 'package:api_series/request/fetch_search.dart';
// // import 'package:api_series/widgets/show_search_delegate.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
// // import 'package:provider/provider.dart';
// // import '../request/show_list.dart';
// // import '../widgets/search_appbar.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({Key? key}) : super(key: key);

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // FetchSearch showsList = FetchSearch();

// // class _HomePageState extends State<HomePage> {
// //   double value = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: GradientColor.gradient,
// //       child: Scaffold(
// //         appBar: SearchAppbar(
// //             searchDelegate: ShowSearchDelegate(showsList: showsList)),
// //         body: const ShowsList(),
// //         drawer: Drawer(
// //             backgroundColor: Colors.transparent,
// //             child: Container(
// //                 decoration: GradientColor.gradient,
// //                 child: ListView(children: <Widget>[
// //                   DrawerHeader(
// //                       child: Image.asset(
// //                     'lib/images/showanalytic_logo.png',
// //                     width: 50,
// //                   )),
// //                   ListTile(
// //                     leading: const Icon(Icons.login, color: Colors.white),
// //                     title: const Text(
// //                       "LOGOUT",
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                     onTap: () {
// //                       final provider = Provider.of<GoogleSignInProvider>(
// //                           context,
// //                           listen: false);
// //                       provider.logoutGoogle();
// //                     },
// //                   ),
// //                 ]))),
// //         bottomNavigationBar: SnakeNavigationBar.color(
// //           backgroundColor:
// //               const Color.fromARGB(255, 0, 70, 78).withOpacity(0.8),
// //           snakeViewColor: const Color(0xFF03252D),
// //           shape:
// //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //           selectedItemColor: Colors.white,
// //           unselectedItemColor: Colors.black,
// //           items: const [
// //             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
// //             BottomNavigationBarItem(
// //                 icon: Icon(Icons.star, color: Colors.white),
// //                 label: 'my reviews'),
// //             BottomNavigationBarItem(
// //                 icon: Icon(Icons.person, color: Colors.white),
// //                 label: 'profile'),
// //           ],
// //         ),
// //         backgroundColor: Colors.transparent,
// //       ),
// //     );
// //   }
// // }
import 'package:api_series/pages/favorite_page.dart';
import 'package:api_series/pages/home_page.dart';
import 'package:api_series/pages/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';

import '../config/gradientbackground.dart';
import '../login/google_sign_in_provider.dart';
import '../login/login_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomSelectedIndex = 0;

  final PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: controller,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children:const <Widget>[
        HomePage(),
        FavoritePage(),
        ProfilePage(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(
      () {
        bottomSelectedIndex = index;
      },
    );
  }

  void bottomTapped(int index) {
    setState(
      () {
        bottomSelectedIndex = index;
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: buildPageView(),
        drawer: Drawer(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: GradientColor.gradient,
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      child: Image.asset(
                        'lib/images/showanalytic_logo.png',
                        width: 50,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.login, color: Colors.white),
                      title: const Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {                
                        final currentUserAuthProvider = FirebaseAuth
                            .instance.currentUser!.providerData[0].providerId;
                        if (currentUserAuthProvider == "password") {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          await provider.logoutGoogle();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
        bottomNavigationBar: SnakeNavigationBar.color(
              
              currentIndex: bottomSelectedIndex,
              onTap: (index) {
                bottomTapped(index);
              },
              backgroundColor:
                  const Color.fromARGB(255, 0, 70, 78).withOpacity(0.8),
              snakeViewColor: const Color(0xFF03252D),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
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
      ),
    );
  }
}