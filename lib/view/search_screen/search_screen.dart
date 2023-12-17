import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_api_11_12/controller/search_controller.dart';
import 'package:news_api_11_12/view/content_screen/content_screen.dart';
import 'package:news_api_11_12/view/home_screen/news_card.dart';
import 'package:news_api_11_12/view/search_screen/search_listview.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchScreenController = Provider.of<SearchScreenController>(context);
    TextEditingController searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          title: SizedBox(
            height: 40,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: InkWell(
                      onTap: () {
                        Provider.of<SearchScreenController>(context,
                                listen: false)
                            .SearchData(
                                searchData:
                                    searchController.text.toLowerCase());
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Icon(Icons.search)),
                  suffixIconColor: Colors.white,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
          ),
        ),
        body: Provider.of<SearchScreenController>(context).isLoading == true
            ? Center(
                child: Lottie.asset("assets/lottie/newsloading.json",
                    height: 150, width: 150))
            : ListView.separated(
                itemCount:
                    searchScreenController.searchResponce?.articles?.length ??
                        0,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContentScreen(
                                  index: index,
                                  image: searchScreenController.searchResponce
                                          ?.articles?[index].urlToImage ??
                                      "",
                                  title: searchScreenController.searchResponce
                                          ?.articles?[index].title ??
                                      "",
                                  author: searchScreenController.searchResponce
                                          ?.articles?[index].author ??
                                      "",
                                  publisher: searchScreenController
                                          .searchResponce
                                          ?.articles?[index]
                                          .source
                                          ?.name ??
                                      "",
                                  content: searchScreenController.searchResponce
                                          ?.articles?[index].content ??
                                      "",
                                  contentUrl: searchScreenController
                                          .searchResponce
                                          ?.articles?[index]
                                          .url ??
                                      "",
                                )),
                      );
                    },
                    child: Newscard(
                        publisher: searchScreenController.searchResponce
                                ?.articles?[index].source?.name ??
                            "",
                        author: searchScreenController
                                .searchResponce?.articles?[index].author ??
                            "",
                        title: searchScreenController
                                .searchResponce?.articles?[index].title ??
                            "",
                        description: searchScreenController
                                .searchResponce?.articles?[index].description ??
                            "",
                        dateTime: searchScreenController
                                .searchResponce?.articles?[index].publishedAt
                                .toString() ??
                            "",
                        image: searchScreenController.searchResponce?.articles?[index].urlToImage ?? "")),
                separatorBuilder: (context, index) => Divider(
                  thickness: 2,
                ),
              ));
  }
}
