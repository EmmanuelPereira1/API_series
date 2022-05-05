import 'package:flutter/material.dart';

import '../request/show_list.dart';
import '../widgets/custom_appbar.dart';

class ShowInfo extends StatefulWidget {
  int id;
  String name;
  String startDate;
  String country;
  String network;
  String status;
  String imageThumbnailPath;

  ShowInfo({
    Key? key,
    required this.id,
    required this.name,
    required this.country,
    required this.network,
    required this.startDate,
    required this.status,
    required this.imageThumbnailPath,
  }) : super(key: key);

  @override
  State<ShowInfo> createState() => _ShowInfoState();
}

class _ShowInfoState extends State<ShowInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
                [const CustomAppBar()],
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 350),
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.imageThumbnailPath)),
                  ),
                  child: Row(
                  children: [
                    Text(widget.status, style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.circle, size: 5, color: Colors.white),
                    SizedBox(width: 5,),
                    Text(widget.country, style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.circle, size: 5, color: Colors.white),
                    SizedBox(width: 5,),
                    Text(widget.network, style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),),
                  ],
                ),
                ),
              ],
            )));
  }
}
