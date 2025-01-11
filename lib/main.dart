import 'package:flutter/material.dart';
import 'package:movie_assignment/provider/profile_provider.dart';
import 'package:movie_assignment/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'provider/movie_provider.dart';
import 'provider/search_view_provider.dart';
import 'provider/splash_state_manager.dart';
import 'provider/tab_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),  // Register the provider
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
  ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Clone',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: Colors.black),
      ),
      home: const SplashScreen(),
    );
  }
}
