import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:mymovies_app/src/services/movies_service.dart';
import 'package:mymovies_app/src/theme/theme.dart';
import 'package:mymovies_app/src/widgets/popular_movies.dart';
import 'package:mymovies_app/src/widgets/search_delegate.dart';

class HomePage extends StatelessWidget {
  final moviesService = new MoviesService();

  @override
  Widget build(BuildContext context) {
    moviesService.getPopularMovies();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            tooltip: 'Search a movie',
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: 
                    FadeIn(
                      duration: Duration(milliseconds: 600),
                      child: Text('Popular movies', style: Theme.of(context).textTheme.headline4,)
                    )
                  ),
                  SizedBox(height: 15.0),
                  StreamBuilder(
                    stream: moviesService.popularsStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return PopularMoviesList(
                          movies: snapshot.data,
                          nextPage: moviesService.getPopularMovies,
                        );
                      } else {
                        return Center(child: CircularProgressIndicator(color: myTheme.primaryColor));
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}