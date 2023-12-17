import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_api_11_12/controller/api_controller.dart';
import 'package:news_api_11_12/controller/category_controller.dart';
import 'package:news_api_11_12/model/newsApiModel/news%20_api_model.dart';
import 'package:news_api_11_12/utils/image_constants/image_constants.dart';
import 'package:news_api_11_12/view/content_screen/content_screen.dart';
import 'package:news_api_11_12/view/home_screen/news_card.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_11_12/view/search_screen/search_screen.dart';
import 'package:provider/provider.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Source sourceArticle = Source();
  // ApiController categoryController = ApiController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    Provider.of<CategoryController>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController =
        Provider.of<CategoryController>(context);
    return DefaultTabController(
      length: categoryController.categoryList.length,
      initialIndex: 0,
      child: Scaffold(
          // Appbar
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("News App"),
            titleTextStyle:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500),
            actions: [
              // Search Icon
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                },
                child: Image.asset(
                  ConstantImages.searchIcon,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 15),
              unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.bold),
              tabs: List.generate(
                  categoryController.categoryList.length,
                  (index) => Tab(
                        text: categoryController.categoryList[index],
                      )),
              onTap: (value) {
                categoryController.onTap(index: value);
              },
            ),
          ),
          body: categoryController.isLoading == true
              ? Center(
                  child: Lottie.asset("assets/lottie/newsloading.json",
                      height: 150, width: 150))
              : ListView.separated(
                  itemCount:
                      categoryController.newsApiResponce.articles?.length ?? 0,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContentScreen(
                                index: index,
                                title: categoryController.newsApiResponce
                                        .articles?[index].title ??
                                    "",
                                image: categoryController.newsApiResponce
                                        .articles?[index].urlToImage ??
                                    "",
                                author: categoryController.newsApiResponce
                                        .articles?[index].author ??
                                    "",
                                publisher: categoryController.newsApiResponce
                                        .articles?[index].source?.name ??
                                    "",
                                content: categoryController.newsApiResponce
                                        .articles?[index].content ??
                                    "",
                                contentUrl: categoryController
                                        .newsApiResponce.articles?[index].url ??
                                    "",
                              )),
                    ),
                    child: Newscard(
                      publisher: categoryController
                              .newsApiResponce.articles?[index].source?.name ??
                          "",
                      author: categoryController
                              .newsApiResponce.articles?[index].author ??
                          "",
                      title: categoryController
                              .newsApiResponce.articles?[index].title ??
                          "",
                      description: categoryController
                              .newsApiResponce.articles?[index].description ??
                          "",
                      dateTime: categoryController
                              .newsApiResponce.articles?[index].publishedAt
                              .toString() ??
                          "",
                      image: categoryController
                              .newsApiResponce.articles?[index].urlToImage ??
                          "",
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(
                    thickness: 2,
                  ),
                )),
    );
  }
}
