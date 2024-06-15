import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Mainscreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Mainscreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),

            ),

            child: Image.asset(
              "img/splash_pic.jpg",
              fit: BoxFit.cover,
              width: width * .9,
              height: height * .5,

            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Text(
            "Top Headlines",
            style: GoogleFonts.anton(
                letterSpacing: .6, color: Colors.grey.shade700),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          SpinKitChasingDots(
            color: Colors.blue,
            size: 40,
          )
        ]),
      ),
    );
  }
}
