import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/newsheadlines.dart';
import 'package:news_app/viewmodel/Categories_screen.dart';
import 'package:news_app/viewmodel/news_view.dart';

import 'model/Topheadlines.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

enum FilterList { bbcNews, abcNews, independent, reuters, cnn, aajtak }

class _MainscreenState extends State<Mainscreen> {
  FilterList? selectedMenu = FilterList.bbcNews; // Set initial value
  NewsviewModel newsviewModel = NewsviewModel();
  final format = DateFormat("MMMM dd, yyyy");
  String name = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<FilterList>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (FilterList item) {
              setState(() {
                selectedMenu = item;
                if (item == FilterList.bbcNews) {
                  name = 'bbc-news';
                } else if (item == FilterList.abcNews) {
                  name = 'abc-news';
                } else if (item == FilterList.cnn) {
                  name = 'cnn';
                } else if (item == FilterList.independent) {
                  name = 'independent';
                } // Add other conditions for other filter options
              });
            },
            initialValue: selectedMenu,
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                child: Text(
                  "BBC news",
                ),
                value: FilterList.bbcNews,
              ),
              PopupMenuItem<FilterList>(
                child: Text("ABC news"),
                value: FilterList.abcNews,
              ),
              PopupMenuItem<FilterList>(
                child: Text("CNN news"),
                value: FilterList.cnn,
              ),
              PopupMenuItem<FilterList>(
                child: Text("Independent news"),
                value: FilterList.independent,
              ),
              // Add other PopupMenuItems for other filter options
            ],
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories_screen()));
          },
          icon: Image.asset(
            "img/category_icon.png",
            height: 30,
            width: 30,
          ),
        ),
        title: Center(
          child: Text(
            "News",
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body:
      ListView(
        children: [

          SizedBox(
            height: height * .55,
            width: width * .55,
            child: FutureBuilder<Newsheadlinesmodels>(
              future: newsviewModel.fetchNewChannelHeadlinesApias(name),
              builder: (BuildContext context, AsyncSnapshot<Newsheadlinesmodels> snapshot) {
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
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return SizedBox(
                        child: Container(
                          child: Stack(
                            alignment: Alignment.center,
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
                                bottom: 20,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    alignment: Alignment.bottomCenter,
                                    height: height * 0.2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot.data!.articles![index].title.toString(),
                                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index].source!.name.toString(),
                                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                format.format(datetime),
                                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
Container(
  child: Text("Top Headlines",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),),
  height: 40,
),

          SizedBox(
            height: height * .55,
            width: width * .55,
            child: FutureBuilder<TophealinesinUS>(
              future: newsviewModel.fetchTopheadlinesApi(),
              builder: (BuildContext context, AsyncSnapshot<TophealinesinUS> snapshot) {
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
                      DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return SizedBox(
                        child: Container(
                          child: Stack(
                            alignment: Alignment.center,
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
                                bottom: 20,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    alignment: Alignment.bottomCenter,
                                    height: height * 0.2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot.data!.articles![index].title.toString(),
                                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index].source!.name.toString(),
                                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                format.format(datetime),
                                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
