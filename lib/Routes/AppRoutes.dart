import 'package:ecommerce_app/Feautres/Home/view/Homepage.dart';
import 'package:ecommerce_app/Splash.dart';
import 'package:flutter/material.dart';

class Approutes {

  static const String Splash = '/';
  static const String Home = '/home';


static Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name){
    case Splash:
      return MaterialPageRoute(builder: (_)=> const SplashScreen());
    case Home:
      return MaterialPageRoute(builder: (_)=> const HomeScreen());
     default:
        // If no route is found, show the splash screen or any fallback screen
        return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
     
}
}