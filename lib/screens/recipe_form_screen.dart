import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../provider/recipe_provider.dart';
import '../provider/theme_provider.dart'; 

class RecipeFormScreen extends StatefulWidget {
  final Recipe? recipe;

  const RecipeFormScreen({super.key, this.recipe});

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;
  
  final List<String> _categories = ['Dessert', 'Seafood', 'Drinks', 'Japanese', 'Chinese', 'Italian', 'Fast Food'];
  String _selectedCategory = 'Dessert';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _ingredientsController = TextEditingController(text: widget.recipe?.ingredients ?? '');
    _instructionsController = TextEditingController(text: widget.recipe?.instructions ?? '');
    if (widget.recipe != null && _categories.contains(widget.recipe!.category)) {
      _selectedCategory = widget.recipe!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<RecipeProvider>();
    bool success;

    final combinedDescription = '${_ingredientsController.text.trim()} \n[SPLIT]\n ${_instructionsController.text.trim()}';

    if (widget.recipe == null) {
      success = await provider.addRecipe(_titleController.text, combinedDescription, _selectedCategory);
    } else {
      success = await provider.editRecipe(widget.recipe!.id!, _titleController.text, combinedDescription, _selectedCategory);
    }

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe saved successfully!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong.'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isLoading = recipeProvider.isLoading;
    final isDark = themeProvider.isDarkMode;

    
    final slideInputDecoration = InputDecoration(
      filled: true,
      fillColor: isDark ? const Color(0xFF1E1E1E) : themeProvider.slideNeutralGray, 
      prefixIconColor: themeProvider.slideLightGray, 
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: themeProvider.slideLightGray, width: 1.5), 
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      labelStyle: const TextStyle(color: Colors.black54), 
    );

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? const Color(0xFF121212) : themeProvider.slideNearWhite,
      appBar: AppBar(
        title: Text(widget.recipe != null ? 'Edit Recipe' : 'Add New Recipe', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? Colors.grey[900] : themeProvider.slideNeutralGray, 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: slideInputDecoration.copyWith(labelText: 'Recipe Title', prefixIcon: const Icon(Icons.fastfood)),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 18),
              
              //Dropdown selector 
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: slideInputDecoration.copyWith(labelText: 'Category Group', prefixIcon: const Icon(Icons.category)),
                iconEnabledColor: themeProvider.slideDarkMauve, 
                items: _categories.map((String cat) {
                  return DropdownMenuItem<String>(
                    value: cat, 
                    child: Text(cat, style: const TextStyle(color: Colors.black87)), 
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() { _selectedCategory = newValue; });
                  }
                },
              ),
              const SizedBox(height: 18),
              
              TextFormField(
                controller: _ingredientsController,
                maxLines: 4,
                decoration: slideInputDecoration.copyWith(labelText: 'Ingredients', prefixIcon: const Icon(Icons.format_list_bulleted)),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter ingredients' : null,
              ),
              const SizedBox(height: 18),
              
              TextFormField(
                controller: _instructionsController,
                maxLines: 4,
                decoration: slideInputDecoration.copyWith(labelText: 'Cooking Instructions', prefixIcon: const Icon(Icons.description)),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter steps' : null,
              ),
              const SizedBox(height: 28),
              
              // Save Button 
              ElevatedButton(
                onPressed: isLoading ? null : _saveForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.slideDarkMauve, 
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : Text(widget.recipe != null ? 'Update Recipe' : 'Save Recipe', style: const TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}