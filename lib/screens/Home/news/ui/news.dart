import 'dart:developer';

import 'package:assignment_kalpas/commom_widgets/transition_widgets/right_to_left/customTransitionFromRightToLeft.dart';
import 'package:assignment_kalpas/data/favourite_article/favourite_article.dart';
import 'package:assignment_kalpas/model/News_data/news_data.dart';
import 'package:assignment_kalpas/screens/Home/news/ui/article_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../bloc/news_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingSuccessState) {
              List<News> news = state.news;
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push(CustomPageRouteRightToLeft(
                            child: NewsArticleContent(
                              newsArticle: news[index],
                            ),
                          )),
                          child: Card(
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.black45,
                            elevation: 20,
                            child: Slidable(
                              endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        BlocProvider.of<NewsBloc>(context).add(
                                            NewsGettingMarkedAsFavourite(
                                                markedAsFavouriteArticle:
                                                    news[index]));
                                        setState(() {});
                                      },
                                      backgroundColor: const Color(0xFFFFCDD2),
                                      foregroundColor: const Color(0xFFE57373),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                      icon: CupertinoIcons.heart_fill,
                                      label: getLabel(index, news),
                                      spacing: 8,
                                    )
                                  ]), //ADD TO FAVOURITE
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  width: double.infinity,
                                  height: 160,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          color: Colors.grey[200],
                                          width: 100,
                                          height: 100,
                                          child: news[index].urlToImage == null
                                              ? const Icon(
                                                  Icons.newspaper,
                                                  color: Colors.black54,
                                                )
                                              : SizedBox(
                                                  child: CachedNetworkImage(
                                                    imageUrl: news[index]
                                                        .urlToImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ), //news_image
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              news[index].title,
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ), //title
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              news[index].description == null
                                                  ? ""
                                                  : news[index]
                                                      .description
                                                      .toString(),
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            ), //description
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.calendar_today,
                                                  color: Colors.black38,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    getDate(news[index]
                                                        .publishedAt),
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ) // publishedAt
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is NewsLoadingErrorState) {
              return const SizedBox(
                child: Text("error"),
              );
            } else {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Card(
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Colors.black45,
                          elevation: 20,
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              width: double.infinity,
                              height: 160,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Shimmer(
                                      duration:
                                          const Duration(milliseconds: 2500),
                                      color: Colors.white.withOpacity(0.5),
                                      colorOpacity: 0.1,
                                      enabled: true,
                                      direction: const ShimmerDirection
                                          .fromLeftToRight(),
                                      child: Container(
                                        color: Colors.grey[200],
                                        width: 100,
                                        height: 100, //news_image
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Shimmer(
                                            duration: const Duration(
                                                milliseconds: 2500),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            colorOpacity: 0.1,
                                            enabled: true,
                                            direction: const ShimmerDirection
                                                .fromLeftToRight(),
                                            child: Container(
                                              height: 14,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            )),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Shimmer(
                                            duration: const Duration(
                                                milliseconds: 2500),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            colorOpacity: 0.1,
                                            enabled: true,
                                            direction: const ShimmerDirection
                                                .fromLeftToRight(),
                                            child: Container(
                                              height: 14,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            )), //title
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Shimmer(
                                            duration: const Duration(
                                                milliseconds: 2500),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            colorOpacity: 0.1,
                                            enabled: true,
                                            direction: const ShimmerDirection
                                                .fromLeftToRight(),
                                            child: Container(
                                              height: 14,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            )),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Shimmer(
                                            duration: const Duration(
                                                milliseconds: 2500),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            colorOpacity: 0.1,
                                            enabled: true,
                                            direction: const ShimmerDirection
                                                .fromLeftToRight(),
                                            child: Container(
                                              height: 14,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            )), //description
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  );
                },
              ); //skeleton loading
            }
          },
        ));
  }

  String getLabel(int index, List<News> news) {
    bool checkLabel = false;
    for (var element in favouriteArticle) {
      if (element.title == news[index].title) checkLabel = true;
    }

    if (checkLabel) {
      return 'Added as Favourite';
    } else {
      return 'Add to Favourite';
    }
  }

  String getDate(String publishedAt) {
    var dateValue = DateTime.parse(publishedAt).toLocal();
    var timeZoneName = dateValue.timeZoneName;
    String formattedDate =
        "${DateFormat("EEEE, dd MMM yyyy hh:mm").format(dateValue)} $timeZoneName";
    log("formattedDate = $formattedDate");
    return formattedDate.toString();
  }
}
