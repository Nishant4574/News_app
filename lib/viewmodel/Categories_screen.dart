import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/Categories_News.dart';

import '../Mainscreen.dart';
import 'news_view.dart';

class Categories_screen extends StatefulWidget {
  const Categories_screen({super.key});

  @override
  State<Categories_screen> createState() => _Categories_screenState();
}

class _Categories_screenState extends State<Categories_screen> {
  NewsviewModel newsviewModel = NewsviewModel();
  final format = DateFormat("MMMM dd, yyyy");
  String CategoryName = "general";
  List<String> AllCategories = [
    'general',
    'Entertainment',
    'Health',
    'Technology',
    'Sports',
    'business',
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories",style: TextStyle(
          fontWeight: FontWeight.w700,fontSize: 29,color: Colors.grey.shade500
        ),),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AllCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          CategoryName = AllCategories[index];
                          // Print the category name to the terminal

                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CategoryName == AllCategories[index]
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Center(
                                  child: Text(
                                AllCategories[index].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsviewModel.fetchCategoriesNewsapi(CategoryName),
              builder: (BuildContext context,
                  AsyncSnapshot<CategoriesNewsModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      DateTime datetime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return Row(
mainAxisAlignment: MainAxisAlignment.center,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Stack(
                              children: [
                                Container(
                                  height: height * .6,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,

                                      placeholder: (context, url) => spinkit2,
                                      errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),
                                    ),
                                  ),
                                ),
                                    Positioned(
                                      left: 27,
                                      bottom: 29
                                      ,
                                      child: Container(
                                      width: width * 0.7,
                                                            child: Text(
                                                            snapshot.data!.articles![index].title.toString(),
                                                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700,color: Colors.white),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            ),
                                                            ),
                                    ),
                              ],
                            ),
                          )
                          ,
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  size: 50,
  color: Colors.blue,
);
