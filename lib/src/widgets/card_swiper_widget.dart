import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> peliculas;

  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSise = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSise.width * 0.7,
        itemHeight:  _screenSise.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0), 
            child: FadeInImage(
              image: NetworkImage( peliculas[index].getPosterImg() ),
              placeholder: AssetImage( 'assets/img/no-image.jpg' ),
              fit: BoxFit.cover
            )
            //Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover,),
          );
        },
        itemCount: peliculas.length,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
      ),
    );
  }
}