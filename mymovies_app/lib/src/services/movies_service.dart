import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:mymovies_app/src/model/movie_model.dart';

class MoviesService {
  // API KEY from TheMovieDB -- Can be replaced by yours
  String _apiKey   = 'ef2d0e038dc6f363ab4689d74d9eb029';
  String _url      = 'api.themoviedb.org';
  // Language to display of the movie
  String _language = 'en-US';

  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = [];

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add; 

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams(){
    _popularsStreamController.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    // Function designed to send the requests of the other functions

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJSONList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'query'     : query
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    if (_loading) return [];

    _loading = true;
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : _popularsPage.toString()
    });

    final response = await _processResponse(url);

    _populars.addAll(response);
    popularsSink(_populars);

    _loading = false;

    return response;
  }
}