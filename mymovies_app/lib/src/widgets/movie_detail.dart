import 'package:flutter/material.dart';
import 'package:mymovies_app/src/model/movie_model.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail(this.movie);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 10.0,
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Extracted widgets for more readability
            MovieTitle(movie: movie),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                MovieImage(movie: movie, size: size),
                
                SizedBox(width: 5.0),
                
                MovieDateVote(movie: movie)
              ]
            ),

            MovieOverview(movie: movie)
          ]
        )
      )
    );
  }
}

class MovieTitle extends StatelessWidget {
  const MovieTitle({
    Key? key,
    required this.movie
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(movie.title!, overflow: TextOverflow.clip, style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center)
    );
  }
}

class MovieImage extends StatelessWidget {
  const MovieImage({
    Key? key,
    required this.movie,
    required this.size
  }) : super(key: key);

  final Movie movie;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        placeholder: AssetImage('assets/img/no-image.jpg'),
        image: NetworkImage(movie.getPosterImg()),
        fit: BoxFit.cover,
        height: size.height * 0.2,
        width: size.width * 0.3
      )
    );
  }
}

class MovieDateVote extends StatelessWidget {
  const MovieDateVote({
    Key? key,
    required this.movie
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowItem(
          text: movie.releaseDate == null || movie.releaseDate == '' ? 'Unkwnown' : 'Release date: ${movie.releaseDate}',
          icon: Icons.calendar_today_outlined
        ),

        SizedBox(height: 5.0),
        
        RowItem(
          text: movie.voteAverage == null ? 'Unkwnown' : 'Average vote: ${movie.voteAverage.toString()}',
          icon: Icons.star_border
        )
      ]
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    Key? key,
    this.text,
    required this.icon
  }) : super(key: key);

  final String? text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(
          '$text',
          overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.subtitle1
        )
      ]
    );
  }
}

class MovieOverview extends StatelessWidget {
  const MovieOverview({
    Key? key,
    required this.movie
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        movie.overview! == 'null' ? 'No overview...' : movie.overview!,
        overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText2,
        maxLines: 3,
        textAlign: TextAlign.justify
      )
    );
  }
}