import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api_11_12/view/content_screen/content_screen.dart';

class Newscard extends StatelessWidget {
  const Newscard(
      {super.key,
      required this.publisher,
      required this.author,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.image});
  final String publisher;
  final String author;
  final String title;
  final String description;
  final String dateTime;
  final String image;

  @override
  Widget build(BuildContext context) {
    final kHeight5 = SizedBox(
      height: 5,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
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
          kHeight5,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                dateTime,
                style: GoogleFonts.poppins(color: Colors.grey),
              )
            ],
          ),
          kHeight5,
          Text(
            description,
            style: GoogleFonts.poppins(),
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
          )
        ],
      ),
    );
  }
}
