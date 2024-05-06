import 'dart:developer';

import 'package:assignment_kalpas/model/News_data/news_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsArticleContent extends StatelessWidget {
  final News newsArticle;

  const NewsArticleContent({super.key, required this.newsArticle});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leadingWidth: 40,
            leading: ModalRoute.of(context)?.canPop == true
                ? IconButton(
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(CupertinoIcons.chevron_back, size: 32),
                  )
                : null,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            title: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                "Back",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            titleSpacing: -8.0),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: ModalRoute.of(context)?.canPop == true
                  ? const SizedBox()
                  : const SizedBox(),
              backgroundColor: Colors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              centerTitle: false,
              stretch: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                      ),
                      child: newsArticle.urlToImage == null
                          ? const Icon(
                              Icons.newspaper,
                              color: Colors.black54,
                            )
                          : SizedBox(
                              child: CachedNetworkImage(
                                imageUrl: newsArticle.urlToImage.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ), //Article_image
            SliverAppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              leading: ModalRoute.of(context)?.canPop == true
                  ? const SizedBox()
                  : const SizedBox(),
              floating: true,
              bottom: newsArticle.title.characters.length <= 80
                  ? const PreferredSize(
                      preferredSize: Size.fromHeight(56), child: SizedBox())
                  : const PreferredSize(
                      preferredSize: Size.fromHeight(86), child: SizedBox()),
              flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsArticle.title,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ), //title
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
                            getDate(newsArticle.publishedAt),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ]),
              )),
            ), //title&PublishedAt
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Text.rich(TextSpan(children: [
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
                  TextSpan(text: newsArticle.content),
                  TextSpan(text: newsArticle.content),
                  TextSpan(text: newsArticle.content),
                  TextSpan(text: newsArticle.content),
                  TextSpan(text: newsArticle.content),
                  TextSpan(text: newsArticle.content),
                  TextSpan(text: newsArticle.content),
                  TextSpan(text: '${newsArticle.content}.'),
                ])),
              ),
            ) //article_content
          ],
        ),
      ),
    );
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
