import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/views/login_view.dart';
import 'package:baza_dan/src/presentation/views/main_view.dart';
import 'package:baza_dan/src/presentation/views/register_second_view.dart';
import 'package:baza_dan/src/presentation/views/register_view.dart';
import 'package:baza_dan/src/presentation/views/splash_screens/splash_screen_view.dart';
import 'package:flutter/material.dart';
class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    final User user;
    switch (settings.name) {
      case '/':
        return _materialRoute(const SplashScreenView());
      case '/login':
        return _createAnimatedRouteRight(const LoginView());
      case '/register':
        return _createAnimatedRouteRight(const RegisterView());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> _createAnimatedRouteRight(Widget view) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0);
        const end = Offset(0, 0);
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }


  static Route<dynamic> _createAnimatedRouteDown(Widget view) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset(0, 0);
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

}