import 'package:assignment_kalpas/data/favourite_article/favourite_article.dart';
import 'package:assignment_kalpas/screens/Home/news/bloc/news_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../../commom_widgets/transition_widgets/right_to_left/customTransitionFromRightToLeft.dart';
import '../../../../model/News_data/news_data.dart';
import '../../news/ui/article_content.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: favouriteArticle.isEmpty ? Center(child: Text("Mark Article as Favourite by Sliding it.",style: TextStyle(fontWeight: FontWeight.bold),)): ListView.builder(
                itemCount: favouriteArticle.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () =>Navigator.of(context).push(CustomPageRouteRightToLeft(child: NewsArticleContent(newsArticle: favouriteArticle[index],),)),
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
                                        BlocProvider.of<NewsBloc>(context).add(NewsGettingUnMarkedAsFavourite(unmarkedAsFavouriteArticle: favouriteArticle[index]));
                                        setState(() {

                                        });
                                      },
                                      backgroundColor: const Color(0xFFE0E0E0),
                                      foregroundColor: const Color(0xFF757575),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                      icon: CupertinoIcons.delete,
                                      label: getLabel(index, favouriteArticle),
                                      spacing: 8,
                                    )
                                  ]),
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
                                        child: Container(
                                          color: Colors.grey[500],
                                          width: 100,
                                          height: 100,
                                          child: favouriteArticle[index].urlToImage == null
                                              ? const Icon(
                                            Icons.newspaper,
                                            color: Colors.black54,
                                          )
                                              : CachedNetworkImage(
                                          imageUrl:  favouriteArticle[index]
                                                .urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                          ), //news_image
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
                                            Text(
                                              favouriteArticle[index].title,
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
                                              favouriteArticle[index].description == null
                                                  ? ""
                                                  : favouriteArticle[index]
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
                                                  CupertinoIcons
                                                      .calendar_today,
                                                  color: Colors.black38,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                   getDate( favouriteArticle[index].publishedAt),
                                                    softWrap: true,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black38,fontWeight: FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ) // publishedAt
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
              ));
  }
  String getLabel(int index, List<News> news) {
    bool checkLabel = false;
    favouriteArticle.forEach((element) {
      if (element.title == news[index].title) checkLabel = true;
    });

    if (checkLabel) {
      return 'Delete from Favourite';
    } else {
      return 'Add to Favourite';
    }
  }
  String getDate(String publishedAt){
    var dateValue = DateTime.parse(publishedAt).toLocal();
    var timeZoneName =  dateValue.timeZoneName;
    String formattedDate = "${DateFormat("EEEE, dd MMM yyyy hh:mm").format(dateValue)} $timeZoneName";
    return formattedDate.toString();
  }
}

/*  child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Colors.grey[500],
                    width: double.infinity,
                    // height: 100,
                    child: newsArticle.urlToImage == null
                        ? const Icon(
                            Icons.newspaper,
                            color: Colors.black54,
                          )
                        : Image.network(
                            newsArticle.urlToImage.toString(),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                 height: 12,
                ),
                Text(
                  newsArticle.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 20),
                ),//title
                const SizedBox(
                  height: 8,
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
                    Text(
                     getDate( newsArticle.publishedAt),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black38,fontWeight: FontWeight.bold),
                    )
                  ],
                ), //publishedAt
                const SizedBox(
                  height: 20,
                ),
                Text.rich(TextSpan(
                  children: [
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: newsArticle.content),
                    TextSpan(text: '${newsArticle.content}.'),
                  ]
                )),


              ],
            ),*/