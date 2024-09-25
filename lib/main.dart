import 'package:flutter/material.dart';
import 'package:cw_2/homescreen.dart';
import 'package:cw_2/favorites_screen.dart';
import 'package:cw_2/recipe.dart';
import 'package:cw_2/details.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatefulWidget {
  const RecipeBookApp({super.key});

  @override
  State<RecipeBookApp> createState() => _RecipeBookAppState();
}

class _RecipeBookAppState extends State<RecipeBookApp> {
  final List<Recipe> favoriteRecipes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(onFavoriteTapped: _handleFavoriteTapped),
        '/details': (context) => DetailsScreen(
            onFavoriteTapped: _handleFavoriteTapped,
            favorites: favoriteRecipes),
        '/favorites': (context) => FavoritesScreen(favorites: favoriteRecipes),
      },
    );
  }

  void _handleFavoriteTapped(Recipe recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }
}