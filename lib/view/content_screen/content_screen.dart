import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api_11_12/controller/api_controller.dart';
import 'package:news_api_11_12/controller/category_controller.dart';
import 'package:news_api_11_12/model/newsApiModel/news%20_api_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({
    super.key,
    required this.index,
    required this.title,
    required this.image,
    required this.author,
    required this.publisher,
    required this.content,
    required this.contentUrl,
  });
  final int index;
  final String title;
  final String image;
  final String author;
  final String publisher;
  final String content;
  final String contentUrl;

  @override
  Widget build(BuildContext context) {
    final kHeight5 = SizedBox(
      height: 5,
    );

    // ApiController apiController = ApiController();
    Future<void> getData() async {
      Provider.of<CategoryController>(context, listen: false).fetchData();
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 23),
              ),
              kHeight5,
              IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                      width: 20,
                    ),
                    Text(
                      publisher,
                      style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              kHeight5,
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(
                content,
                style: GoogleFonts.poppins(),
              ),
              InkWell(
                  onTap: () {
                    Provider.of<CategoryController>(context, listen: false)
                        .launchURL(contentUrl);
                  },
                  child: Text(
                    "Click to read more...",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
