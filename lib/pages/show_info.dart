import 'package:api_series/config/theme.dart';
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
    return Container(
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
            backgroundColor: Colors.transparent,
            body: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    [const CustomAppBar()],
                body: SingleChildScrollView(
                    child: Stack(
                  children: [
                    // AspectRatio(
                    //     aspectRatio: 400 / 451,
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         image: DecorationImage(
                    //             image: NetworkImage(widget.imageThumbnailPath),
                    //             fit: BoxFit.fitWidth,
                    //             ),
                    //       ),

                    //     )),
                    AspectRatio(
                      aspectRatio: 400 / 451,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.imageThumbnailPath),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 410,
                      width: 451,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xCC000000),
                            Color(0x00000000),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 335, 30, 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(widget.status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.normal)),
                              const SizedBox(width: 6),
                              const Icon(Icons.circle,
                                  color: Colors.white, size: 6),
                              const SizedBox(width: 6),
                              Text(widget.country,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.normal)),
                              const SizedBox(width: 6),
                              const Icon(Icons.circle,
                                  color: Colors.white, size: 6),
                              const SizedBox(width: 6),
                              Text(widget.network,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )))));
  }
}
               
