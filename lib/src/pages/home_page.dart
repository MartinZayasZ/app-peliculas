import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_horizontal_widget.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){},)
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas(){

    //este builder nos ayudará en tener datos por default
    return FutureBuilder(
      future:  moviesProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if( snapshot.hasData ){
          return CardSwiper( peliculas: snapshot.data );
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );
  }

  Widget _footer(BuildContext context) {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares', style: Theme.of(context).textTheme.subhead)
            ),
            SizedBox(height: 5.0),
            StreamBuilder(
              //aquí mandamos a llamar a nuestro stream
              stream: moviesProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if( snapshot.hasData ){
                  return MovieHorizontal( 
                    movies: snapshot.data,
                    nextPage: moviesProvider.getPopulars,
                  );
                }else{
                  return Container(
                    height: 50.0,
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              },
            ),
          ],
        ),
      );
  }

}