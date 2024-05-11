import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartshop/screen/cartscreen.dart';
import 'package:smartshop/screen/history/historicscreen.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/screen/splashscreen.dart';
import 'package:smartshop/screen/users/login/loginscreen.dart';
import 'package:smartshop/screen/users/register/registerscreen.dart';
import 'package:smartshop/screen/welcom/welcomscreen.dart';

class AppRouter {
  late final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      name: 'Splash',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: 'welcome',
      path: '/welcome',
      builder: (BuildContext context, GoRouterState state) {
        return const Welcomscreen();
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      name: 'cart',
      path: '/cart',
      builder: (BuildContext context, GoRouterState state) {
        return const CartScreen();
      },
    ),
    GoRoute(
      name: 'historique',
      path: '/historique',
      builder: (BuildContext context, GoRouterState state) {
        return const HistoricScreen();
      },
    ),
  ]);
}
