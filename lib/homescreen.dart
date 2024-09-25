import 'package:flutter/material.dart';
import 'package:cw_2/recipe.dart';

class HomeScreen extends StatelessWidget {
  final void Function(Recipe) onFavoriteTapped; // Add this line

  const HomeScreen(
      {super.key, required this.onFavoriteTapped}); // Update constructor

  Future<List<Recipe>> _loadRecipes(BuildContext context) async {
    List<Map<String, dynamic>> recipes = [
      {
        'name': 'Spaghetti Carbonara',
        'ingredients':
            '1. Spagetti\n2. Eggs\n3. Bacon\n4. Parmesan Cheese',
        'instructions':
            'Cook spaghetti, mix with eggs, bacon, and cheese. Serve hot'
      },
      {
        'name': 'Grilled Chicken',
        'ingredients':
            '1. Bread\n2. Chicken\n3. Spices of choice\n4. Cheese',
        'instructions':
          'Marinate the Chicken with the spices of your choices. Fry the chicken. Fried chicken on bread and add cheese. Grill the bread'
      },
      {
        'name': 'Cup Ramen',
        'ingredients':
            '1. Cup Ramen\n2. Water',
        'instructions':
            'Open the Cup Ramen and add water until the line. Close the lid and place it in microvave for desired time. Eat it.',
      },
    ];

    return recipes
        .map((data) => Recipe(
              data['name'],
              data['ingredients'],
              data['instructions'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: const Text('Recipe Book'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _loadRecipes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<Recipe> recipes = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: {'recipe': recipe},
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.food_bank, size: 48.0),
                        const SizedBox(height: 8.0),
                        Text(
                          recipe.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No recipes available'),
            );
          }
        },
      ),
    );
  }
}