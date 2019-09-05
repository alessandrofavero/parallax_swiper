import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parallax_swiper/parallax_swiper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bg = Container(
      width: 350,
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset('assets/logo.png'),
          SizedBox(
            height: 250,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.center,
            width: 300,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.redAccent, width: 5)),
            child: Text(
              'SELECT CHARACTER',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );

    var mario = Container(
      width: 350,
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/mario.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Mario',
            style: TextStyle(fontFamily: 'SuperMario', fontSize: 40),
          ),
        ],
      ),
    );

    var luigi = Container(
      width: 350,
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/luigi.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Luigi',
            style: TextStyle(fontFamily: 'SuperMario', fontSize: 40),
          ),
        ],
      ),
    );

    var yoshi = Container(
      width: 350,
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/yoshi.png',
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Yoshi',
            style: TextStyle(fontFamily: 'SuperMario', fontSize: 40),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: ParallaxSwiper(
          backgroundWidget: bg,
          foregroundWidgets: <Widget>[mario, luigi, yoshi],
          swipeDirection: Axis.horizontal,
          swiperCurve: Curves.bounceOut,
          returnCurve: Curves.bounceOut,
        ),
      ),
    );
  }
}
