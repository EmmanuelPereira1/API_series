import 'package:flutter/material.dart';

class SearchAppbar extends StatelessWidget with PreferredSizeWidget {
  SearchAppbar({Key? key, this.searchDelegate}) : super(key: key);
  SearchDelegate? searchDelegate;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 70,
        elevation: 0,
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
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: searchDelegate!,
                );
              },
              icon: const Icon(Icons.search))
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
