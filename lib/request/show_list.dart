import 'package:api_series/pages/show_details_page.dart';
import 'package:api_series/request/show_repository.dart';
import 'package:flutter/material.dart';

class ShowsList extends StatefulWidget {
  const ShowsList({Key? key}) : super(key: key);

  @override
  State<ShowsList> createState() => _ShowsListState();
}

class _ShowsListState extends State<ShowsList> {
  late ShowRepository showRepo;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
  late final ScrollController _scrollController2;
  late final ScrollController _scrollController3;

  @override
  void initState() {
    super.initState();
    //First ScrollController
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    //Second ScrollController
    _scrollController2 = ScrollController();
    _scrollController2.addListener(infiniteScrolling2);
    //Third ScrollController
    _scrollController3 = ScrollController();
    _scrollController3.addListener(infiniteScrolling3);
    showRepo = ShowRepository();
    loadShows();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !loading.value) {
      loadShows();
    }
  }

  infiniteScrolling2() {
    if (_scrollController2.position.pixels ==
            _scrollController2.position.maxScrollExtent &&
        !loading.value) {
      loadShows();
    }
  }

  infiniteScrolling3() {
    if (_scrollController2.position.pixels ==
            _scrollController2.position.maxScrollExtent &&
        !loading.value) {
      loadShows();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
  }

  loadShows() async {
    loading.value = true;
    await showRepo.getShows();
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 30),
              Text(
                "RUNNING",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AnimatedBuilder(
                animation: showRepo,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 270,
                    child: Stack(
                      children: [
                        ListView.separated(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            itemBuilder: ((context, index) {
                              final show = showRepo.shows[index];
                              if (show.status == "Running") {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.transparent,
                                      child: Ink(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) => ShowDetailsPage(
                                                      id: show.id,
                                                    )),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      show.imageThumbnailPath),
                                                  fit: BoxFit.cover,
                                                  opacity: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color: Colors.black,
                                            ),
                                            height: 230,
                                            width: 160,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox(width: 0);
                              }
                            }),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: showRepo.shows.length),
                        // loadingIndicatorWidget()
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 30),
              Text(
                "ENDED",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AnimatedBuilder(
                animation: showRepo,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 270,
                    child: Stack(
                      children: [
                        ListView.separated(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController2,
                            itemBuilder: ((context, index) {
                              final show = showRepo.shows[index];
                              if (show.status == "Ended") {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.transparent,
                                      child: Ink(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) => ShowDetailsPage(
                                                      id: show.id,
                                                    )),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      show.imageThumbnailPath),
                                                  fit: BoxFit.cover,
                                                  opacity: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color: Colors.black,
                                            ),
                                            height: 230,
                                            width: 160,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox(width: 0);
                              }
                            }),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: showRepo.shows.length),
                        // loadingIndicatorWidget()
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 30),
              Text(
                "UNDETERMINED",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AnimatedBuilder(
                animation: showRepo,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 270,
                    child: Stack(
                      children: [
                        ListView.separated(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController3,
                            itemBuilder: ((context, index) {
                              final show = showRepo.shows[index];
                              if (show.status == "To Be Determined") {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.transparent,
                                      child: Ink(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) => ShowDetailsPage(
                                                      id: show.id,
                                                    )),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      show.imageThumbnailPath),
                                                  fit: BoxFit.cover,
                                                  opacity: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color: Colors.black,
                                            ),
                                            height: 230,
                                            width: 160,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox(width: 0);
                              }
                            }),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: showRepo.shows.length),
                        // loadingIndicatorWidget()
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 20,
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ))
              : Container();
        });
  }
}
