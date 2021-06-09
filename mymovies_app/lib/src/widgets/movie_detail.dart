import 'package:flutter/material.dart';
import 'package:mymovies_app/src/model/movie_model.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail(this.movie);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Release date: ${movie.releaseDate == null || movie.releaseDate == '' ? 'Unkwnown' : movie.releaseDate}', overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline6),
                  Text('Average vote: ${movie.voteAverage == null ? 'Unkwnown' : movie.voteAverage}', overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline6),
                ],
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