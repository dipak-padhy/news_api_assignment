import 'package:assignment_kalpas/screens/Home/favourite/ui/favourite.dart';
import 'package:assignment_kalpas/screens/Home/news/bloc/news_bloc.dart';
import 'package:assignment_kalpas/screens/Home/news/ui/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(NewsInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top:16),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                    physics: const BouncingScrollPhysics(),
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight:0,
                    padding: EdgeInsets.zero,
                    indicator: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.blueAccent.withOpacity(0.1)),
                    unselectedLabelColor: Colors.grey,
                    labelPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 28),
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    labelColor: Colors.white,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.resolveWith(
                      (Set states) {
                        return states.contains(MaterialState.focused)
                            ? null
                            : Colors.transparent;
                      },
                    ),
                    tabs: [
                      const Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dehaze,
                              size: 24,
                              color: Colors.black,
                            ),
                            SizedBox(width: 8,),
                            Text("News",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.black),)
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.heart_fill,
                              size: 24,
                              color: Colors.red[300],
                            ),
                            const SizedBox(width: 8,),
                            const Text("Favs",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.black),)
                          ],
                        ),
                      ),
                    ]),
                const SizedBox(height: 8,),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top:8),
                    child: TabBarView(children: [
                      NewsScreen(),
                      FavouritesScreen(),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
