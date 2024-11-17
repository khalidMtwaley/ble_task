import 'package:flutter/material.dart';

enum NavigationAnimation {
  fade,
  slideRight,
  slideLeft,
  slideUp,
  slideDown,
  none, 
}

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Push 
  Future<dynamic> push(
    Widget page, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.push(
      createRoute(page, animation: animation, arguments: arguments),
    );
  }

  // pushReplacement
  Future<dynamic> pushReplacement(
    Widget page, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacement(
      createRoute(page, animation: animation, arguments: arguments),
    );
  }

  // pushNamed
  Future<dynamic> pushNamed(
    String routeName, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.push(
      _createRouteForNamedRoute(routeName, animation: animation, arguments: arguments),
    );
  }

  // pushReplacementNamed
  Future<dynamic> pushReplacementNamed(
    String routeName, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacement(
      _createRouteForNamedRoute(routeName, animation: animation, arguments: arguments),
    );
  }

  // pushAndRemoveUntil
  Future<dynamic> pushAndRemoveUntil(
    Widget page,
    RoutePredicate predicate, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      createRoute(page, animation: animation, arguments: arguments),
      predicate,
    );
  }

  // Pop 
  void pop() {
    navigatorKey.currentState!.pop();
  }

  // Pop until 
  void popUntil(RoutePredicate predicate) {
    navigatorKey.currentState!.popUntil(predicate);
  }

  // Pop and push named
  Future<dynamic> popAndPushNamed(
    String routeName, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    navigatorKey.currentState!.pop();
    return pushNamed(routeName, animation: animation, arguments: arguments);
  }

  // Helper function to create the route with animation
  Route createRoute(
    Widget page, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    switch (animation) {
      case NavigationAnimation.fade:
        return PageRouteBuilder(
          settings: RouteSettings(arguments: arguments),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 300),
        );
      case NavigationAnimation.slideRight:
        return PageRouteBuilder(
          settings: RouteSettings(arguments: arguments),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: Offset(-1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
          transitionDuration: Duration(milliseconds: 300),
        );
      case NavigationAnimation.slideLeft:
        return PageRouteBuilder(
          settings: RouteSettings(arguments: arguments),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
          transitionDuration: Duration(milliseconds: 300),
        );
      case NavigationAnimation.slideUp:
        return PageRouteBuilder(
          settings: RouteSettings(arguments: arguments),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
          transitionDuration: Duration(milliseconds: 300),
        );
      case NavigationAnimation.slideDown:
        return PageRouteBuilder(
          settings: RouteSettings(arguments: arguments),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: Offset(0.0, -1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
          transitionDuration: Duration(milliseconds: 300),
        );
      case NavigationAnimation.none:
      default:
        return MaterialPageRoute(
          builder: (context) => page,
          settings: RouteSettings(arguments: arguments),
        );
    }
  }

  Route _createRouteForNamedRoute(
    String routeName, {
    NavigationAnimation animation = NavigationAnimation.none,
    Object? arguments,
  }) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: arguments),
      pageBuilder: (context, anim, secondaryAnim) {
        final route = navigatorKey.currentState!.widget.onGenerateRoute!(
          RouteSettings(name: routeName, arguments: arguments),
        );

        if (route != null) {
          if (route is MaterialPageRoute) {
            return route.builder(context);
          } else {
            return Scaffold(body: Center(child: Text('Route not found',style: TextStyle(fontSize: 20,),)));
          }
        } else {
          return Scaffold(body: Center(child: Text('Route not found')));
        }
      },
      transitionsBuilder: (context, anim, secondaryAnim, child) {
        switch (animation) {
          case NavigationAnimation.fade:
            return FadeTransition(opacity: anim, child: child);
          case NavigationAnimation.slideRight:
            return SlideTransition(
              position: Tween(begin: Offset(-1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)).animate(anim),
              child: child,
            );
          case NavigationAnimation.slideLeft:
            return SlideTransition(
              position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)).animate(anim),
              child: child,
            );
          case NavigationAnimation.slideUp:
            return SlideTransition(
              position: Tween(begin: Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)).animate(anim),
              child: child,
            );
          case NavigationAnimation.slideDown:
            return SlideTransition(
              position: Tween(begin: Offset(0.0, -1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)).animate(anim),
              child: child,
            );
          case NavigationAnimation.none:
          default:
            return child;
        }
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
