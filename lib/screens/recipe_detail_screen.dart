import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../provider/theme_provider.dart'; 

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? const Color(0xFF121212) : themeProvider.slideNearWhite,
      appBar: AppBar(
        title: const Text('Recipe Details', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            
            // HEADER PANEL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                
                color: isDark ? themeProvider.slideAccentMutedMauve.withOpacity(0.05) : themeProvider.slideAccentMutedMauve,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: isDark ? const Color(0xFF121212) : themeProvider.slideNearWhite,
                    child: Icon(Icons.restaurant, color: themeProvider.slideDarkMauve, size: 45), 
                  ),
                  const SizedBox(height: 20),
                  Text(
                    recipe.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  Text(
                    recipe.category,
                    style: TextStyle(color: themeProvider.slideDarkMauve, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // INGREDIENTS SECTION 
            _buildSectionHeader(context, themeProvider, Icons.shopping_basket, 'Ingredients'),
            const SizedBox(height: 10),
            _buildContentCard(context, themeProvider, recipe.ingredients),
            
            const SizedBox(height: 28),

            // INSTRUCTIONS SECTION 
            if (recipe.instructions.isNotEmpty) ...[
              _buildSectionHeader(context, themeProvider, Icons.menu_book, 'Instructions'),
              const SizedBox(height: 10),
              _buildContentCard(context, themeProvider, recipe.instructions),
            ],
          ],
        ),
      ),
    );
  }

  
  Widget _buildSectionHeader(BuildContext context, ThemeProvider themeProvider, IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: themeProvider.slideLightGray), 
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ],
    );
  }

  // Content card
  Widget _buildContentCard(BuildContext context, ThemeProvider themeProvider, String content) {
    return Card(
      elevation: 0,
      color: themeProvider.isDarkMode ? const Color(0xFF1E1E1E) : themeProvider.slideNeutralGray, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            content,
            style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87), 
          ),
        ),
      ),
    );
  }
}