import 'package:flutter/material.dart';
import 'package:mymovies_app/src/model/movie_model.dart';

import 'package:mymovies_app/src/services/movies_service.dart';
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
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blueAccent,
          child: Text("data"),
        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Suggestions while typing
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesService.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return  ListView(
            children: movies!.map((movie){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                child: MovieDetail(movie),
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }  
    );
  }
  
}

// Modelo de build suggestions
// final listaSugerida = (query.isEmpty) 
//                             ? peliculasRecientes 
//                             : peliculas.where(
//                               (p) => p.toLowerCase().startsWith(query.toLowerCase())
//                             ).toList();

//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (context, i){
//         return ListTile(
//           leading: Icon(Icons.movie),
//           title: Text(listaSugerida[i]),
//           onTap: (){
//             seleccion = listaSugerida[i];
//             showResults(context);
//           },
//         );
//       }
//       );