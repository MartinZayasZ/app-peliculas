import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas App',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}