import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/movie_model.dart';

class MoviesProvider{

  String _apiKey  = '421e5acd1f0c72c62d4eec84eb0c1181';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  
  int _popularsPage = 0;

  bool _loading = false;

  List<Movie> _populars = new List();

  //Comienza stream
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  void disposeStream(){
    _popularsStreamController?.close();
  }

  //es para guardar datos en stream
  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;
  
  //sirve para obtener los valores
  Stream<List<Movie>> get popularesStream => _popularsStreamController.stream;

  //termina código para stream


  Future<List<Movie>> getEnCines() async{

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apiKey,
      'language' : _language
    });

    return await _procesarRespuesta(url);

  }

  Future<List<Movie>> getPopulars() async{
    
    //validamos que el getPopulars no se este ejecutando
    if(_loading) return [];
    _loading = true;

    //cada ves que se ejecuta el metodo se incrementa la página
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apiKey,
      'language' : _language,
      'page'  : _popularsPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populars.addAll( resp );

    //aquí guardamos los datos para el stream mediante sink
    popularsSink( _populars );

    //indicamos que ya no se esta ejecutando el metodo
    _loading = false;

    return resp;

  }

  Future<List<Movie>> _procesarRespuesta(Uri url) async{

    final resp = await http.get( url );
    final decodedData = json.decode( resp.body );
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;

  }

}