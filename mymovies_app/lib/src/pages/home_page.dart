import 'package:flutter/material.dart';

import 'package:mymovies_app/src/services/movies_service.dart';
import 'package:mymovies_app/src/shared_preferences/shared_preferences.dart';
import 'package:mymovies_app/src/theme/theme.dart';
import 'package:animate_do/animate_do.dart';

import 'package:mymovies_app/src/widgets/popular_movies.dart';
import 'package:mymovies_app/src/widgets/search_delegate.dart';

class HomePage extends StatelessWidget {
  final moviesService = new MoviesService();
  final _preferences = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    moviesService.getPopularMovies();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton.icon(
            label: Text('Log out', style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.logout_outlined, color: Colors.white),
            onPressed: () {
              _preferences.token = '';
              Navigator.pushReplacementNamed(context, 'login');
            }
          ),

          TextButton.icon(
            label: Text('Search', style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            }
          )
        ]
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
        child: Column(
          children: [
            PageContent(moviesService: moviesService)
          ]
        )
      )
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({
    Key? key,
    required this.moviesService
  }) : super(key: key);

  final MoviesService moviesService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PageTitle(),
          
          SizedBox(height: 15.0),
          
          Movies(moviesService: moviesService)
        ]
      )
    );
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      child: BounceInDown(
        child: Text(
          'Popular movies',
          style: Theme.of(context).textTheme.headline4
        )
      )
    );
  }
}

class Movies extends StatelessWidget {
  const Movies({
    Key? key,
    required this.moviesService
  }) : super(key: key);

  final MoviesService moviesService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: moviesService.popularsStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return PopularMoviesList(
            movies: snapshot.data,
            nextPage: moviesService.getPopularMovies
          );
        } else {
          return Center(child: CircularProgressIndicator(color: myTheme.primaryColor));
        }
      }
    );
  }
}