import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/recipe_provider.dart';
import '../provider/theme_provider.dart';
import '../models/recipe.dart';
import 'recipe_form_screen.dart';
import 'recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final List<String> _categories = ['All', 'Dessert', 'Seafood', 'Drinks', 'Japanese', 'Chinese', 'Italian', 'Fast Food'];
  String _activeCategory = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<RecipeProvider>().loadRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    final List<Recipe> filteredRecipes = recipeProvider.recipes.where((recipe) {
      final matchesCategory = _activeCategory == 'All' || recipe.category == _activeCategory;
      final matchesSearch = recipe.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      
      appBar: AppBar(
       
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : const Color(0xFFF3F3F3), 
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() { _searchQuery = value; });
            },
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              hintText: 'Search',
              hintStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 14),
              prefixIcon: Icon(Icons.search, color: themeProvider.slideLightGray, size: 20),
              border: InputBorder.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Day/Night View Mode',
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Left nav side bar
          Material(
            elevation: 1,
            child: Container(
              width: 100,
              color: isDark ? const Color(0xFF1A1A1A) : themeProvider.slideNearWhite,
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, idx) {
                  final categoryName = _categories[idx];
                  final isSelected = categoryName == _activeCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() { _activeCategory = categoryName; });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                      decoration: BoxDecoration(
                        
                        color: isSelected 
                            ? (isDark ? themeProvider.slideAccentMutedMauve.withOpacity(0.1) : themeProvider.slideAccentMutedMauve) 
                            : Colors.transparent,
                        border: Border(
                          left: BorderSide(
                          
                            color: isSelected ? themeProvider.slideLightGray : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        categoryName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected 
                              ? (isDark ? Colors.white : themeProvider.slideDarkMauve) 
                              : (isDark ? Colors.grey[400] : Colors.black54),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          const VerticalDivider(width: 1, thickness: 0.5),

          // Recipe grid display
          Expanded(
            child: recipeProvider.isLoading && recipeProvider.recipes.isEmpty
                ? const Center(child: CircularProgressIndicator(color: Colors.grey)) 
                : recipeProvider.errorMessage.isNotEmpty
                    ? Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(recipeProvider.errorMessage, style: const TextStyle(color: Colors.black), textAlign: TextAlign.center)))
                    : filteredRecipes.isEmpty
                        ? const Center(child: Text('No matching recipes found!', style: TextStyle(color: Colors.grey)))
                        : GridView.builder(
                            padding: const EdgeInsets.all(6),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              childAspectRatio: 0.85,
                            ),
                            itemCount: filteredRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = filteredRecipes[index];

                              return Card(
                                elevation: 0, 
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                color: isDark ? const Color(0xFF252525) : themeProvider.slideNeutralGray, 
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 12.0, left: 4.0, right: 4.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              
                                              CircleAvatar(
                                                radius: 50,
                                                backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                                                child: Icon(Icons.restaurant, color: themeProvider.slideLightGray, size: 18),
                                              ),
                                              const SizedBox(height: 17),
                                              Text(
                                                recipe.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87), 
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 17),
                                              
                                              Text(
                                                recipe.category,
                                                style: TextStyle(color: themeProvider.slideDarkMauve, fontSize: 11, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(height: 1, thickness: 0.5),
                                    Container(
                                      color: isDark ? const Color(0xFF202020) : themeProvider.slideNeutralGray, 
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(40, 25)),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (_) => RecipeFormScreen(recipe: recipe)),
                                              );
                                            },
                                            child: const Text('Edit', style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                                          ),
                                          Container(width: 0.5, height: 14, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                                          TextButton(
                                            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(40, 25)),
                                            onPressed: () {
                                              context.read<RecipeProvider>().removeRecipe(recipe.id!);
                                            },
                                            child: const Text('Delete', style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeProvider.slideDarkMauve, 
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RecipeFormScreen()),
          );
        },
      ),
    );
  }
}