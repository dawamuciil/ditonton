import 'package:core/utils/constants.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:tv_shows/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeMoviePage(),
    HomeTvPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.movie),
                title: Text('Movies'),
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.tv),
                title: Text('Tv'),
                selectedColor: Colors.white,
              ),
            ]));
  }
}
