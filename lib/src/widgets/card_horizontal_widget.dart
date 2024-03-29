import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;

  final Function nextPage;

  MovieHorizontal({ @required this.movies, @required this.nextPage }); 

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSise = MediaQuery.of(context).size;

    _pageController.addListener( (){
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        nextPage();
        print('Cargando peliculas');
      }
    });
  
    return Container(
      height: _screenSise.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _cards(context)
        itemBuilder: ( context, i ) {
          
        } ,
      ),
    );

  }

  List<Widget> _cards(BuildContext context){

    return movies.map( (pelicula ) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
    
  }

}
