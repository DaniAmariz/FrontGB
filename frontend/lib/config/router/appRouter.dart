import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/interface/screens/user/profileScreen.dart';
import 'package:frontend/interface/screens/home/homeScreenContainer.dart';
import 'package:frontend/interface/screens/auth/loginScreen.dart';
import 'package:frontend/interface/screens/auth/registerScreen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: LoginScreen.name,
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      name: HomeScreenContainer.name,
      builder: (BuildContext context, GoRouterState state) =>
        const HomeScreenContainer(),
    ),
    GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (BuildContext context, GoRouterState state) =>
         const RegisterScreen(),
    ),
    GoRoute(
      path: '/user',
      name: ProfileScreen.name,
      builder: (BuildContext context, GoRouterState state) =>
      const ProfileScreen(),
    )
  ],
);