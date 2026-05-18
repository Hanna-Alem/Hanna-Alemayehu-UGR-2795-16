import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // GET: Fetch Recipes
  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        
        return body.take(15).map((item) => Recipe.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load recipes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error occurred: $e');
    }
  }

  // POST: Create Recipe
  Future<Recipe> createRecipe(Recipe recipe) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(recipe.toJson()),
      );

      if (response.statusCode == 201) {
        return Recipe.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create recipe.');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // PUT: Update Recipe
  Future<Recipe> updateRecipe(int id, Recipe recipe) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(recipe.toJson()),
      );

      if (response.statusCode == 200) {
        return Recipe.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update recipe.');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // DELETE: Delete Recipe
  Future<void> deleteRecipe(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete recipe.');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}