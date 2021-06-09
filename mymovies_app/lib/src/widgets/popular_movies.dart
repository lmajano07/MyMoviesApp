import 'package:flutter/material.dart';

import 'package:mymovies_app/src/model/movie_model.dart';
import 'package:mymovies_app/src/widgets/movie_detail.dart';

class PopularMoviesList extends StatelessWidget {

  final List<Movie>? movies;
  final Function? nextPage;

  PopularMoviesList({@required this.movies, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 0,
    viewportFraction: 0.6,
  );

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage!();
      }
    });
    return Container(
      height: _size.height * 0.75,
      child: PageView.builder(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        pageSnapping: false,
        itemCount: movies!.length,
        itemBuilder: (context, i){
          // return _card(context, movies![i], _size);
          return MovieDetail(movies![i]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie, Size size){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(movie.title!, overflow: TextOverflow.clip, style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.getPosterImg()),
                  fit: BoxFit.cover,
                  height: size.height * 0.2,
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                padding: EdgeInsets.only(right: 20.0),
                margin: EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Release date: ${movie.releaseDate == null || movie.releaseDate == '' ? 'Unkwnown' : movie.releaseDate}', overflow: TextOverflow.fade, style: Theme.of(context).textTheme.headline6),
                    Text('Average vote: ${movie.voteAverage == null ? 'Unkwnown' : movie.voteAverage}', overflow: TextOverflow.fade, style: Theme.of(context).textTheme.headline6),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Text(movie.overview! == 'null' ? 'No overwview...' : movie.overview!, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline6, maxLines: 3, textAlign: TextAlign.justify,)
          ),
          Divider(thickness: 2.0)
        ],
      ),
    );
  }
}