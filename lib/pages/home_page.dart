import 'package:api_series/config/gradientbackground.dart';
import 'package:api_series/login/login_page.dart';
import 'package:api_series/request/fetch_search.dart';
import 'package:api_series/widgets/custom_drawer.dart';
import 'package:api_series/widgets/show_search_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';
import '../login/google_sign_in_provider.dart';
import '../request/show_list.dart';
import '../widgets/search_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

FetchSearch showsList = FetchSearch();

class _HomePageState extends State<HomePage> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GradientColor.gradient,
      child: Scaffold(
        appBar: SearchAppbar(
            searchDelegate: ShowSearchDelegate(showsList: showsList)),
        body: const ShowsList(),
        drawer: const CustomDrawer(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}