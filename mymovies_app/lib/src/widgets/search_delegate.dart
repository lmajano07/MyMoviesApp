import 'package:flutter/material.dart';
import 'package:mymovies_app/src/model/movie_model.dart';

import 'package:mymovies_app/src/services/movies_service.dart';
import 'package:mymovies_app/src/theme/theme.dart';
import 'package:mymovies_app/src/widgets/movie_detail.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final moviesService = new MoviesService();

  @override
  List<Widget> buildActions(BuildContext context) {
      // Actions in AppBar
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          }
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icon to the left
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation 
        ),
        onPressed: (){
          close(context, null);
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Creates results to display
      return Results(moviesService: moviesService, query: query);
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Suggestions while typing
    if (query.isEmpty) {
      return Center(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Start typing to see results', style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.center),
            SizedBox(height: 40.0),
            CircularProgressIndicator(color: myTheme.primaryColor)
          ],
        ),
      ));
    }
    return Results(moviesService: moviesService, query: query);
  } 
}

class Results extends StatelessWidget {
  const Results({
    Key? key,
    required this.moviesService,
    required this.query,
  }) : super(key: key);

  final MoviesService moviesService;
  final String query;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesService.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return  ListView(
            children: movies!.map((movie){
              return MovieDetail(movie);
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: myTheme.primaryColor),
          );
        }
      }  
    );
  }
}