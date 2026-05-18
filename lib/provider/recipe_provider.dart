import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      _recipes = await _apiService.fetchRecipes();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addRecipe(String title, String description, String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      final newRecipe = Recipe(title: title, description: description, category: category);
      final created = await _apiService.createRecipe(newRecipe);
      
      final uniqueRecipe = Recipe(
        id: _recipes.length + 1, 
        title: created.title, 
        description: created.description,
        category: category,
      );
      
      _recipes.insert(0, uniqueRecipe);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> editRecipe(int id, String title, String description, String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      final updatedData = Recipe(id: id, title: title, description: description, category: category);
      try {
        await _apiService.updateRecipe(id, updatedData);
      } catch (_) {}

      int index = _recipes.indexWhere((r) => r.id == id);
      if (index != -1) {
        _recipes[index] = updatedData;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> removeRecipe(int id) async {
    try {
      _recipes.removeWhere((r) => r.id == id);
      notifyListeners();
      await _apiService.deleteRecipe(id);
    } catch (e) {
      loadRecipes();
    }
  }
}