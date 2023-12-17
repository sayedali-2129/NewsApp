import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SearchListView extends StatelessWidget {
  const SearchListView(
      {super.key,
      required this.title,
      required this.image,
      required this.author,
      required this.publisher});
  final String title;
  final String image;
  final String author;
  final String publisher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
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
          )
        ],
      ),
    );
  }
}
