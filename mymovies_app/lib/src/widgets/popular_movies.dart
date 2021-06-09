import 'package:flutter/material.dart';

import 'package:mymovies_app/src/model/movie_model.dart';
import 'package:mymovies_app/src/widgets/movie_detail.dart';

class PopularMoviesList extends StatelessWidget {

  final List<Movie>? movies;
  final Function? nextPage;

  PopularMoviesList({@required this.movies, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 0,
    viewportFraction: 0.6
  );

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 300) {
        nextPage!();
      }
    });
    
    return Container(
      height: _size.height * 0.75,
      child: ListView.builder(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: movies!.length,
        itemBuilder: (context, i){
          return MovieDetail(movies![i]);
        },
      ),
    );
  }
}