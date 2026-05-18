class Recipe {
  final int? id;
  final String title;
  final String description;
  final String category; 

  Recipe({
    this.id,
    required this.title,
    required this.description,
    required this.category,
  });

  String get ingredients {
    if (description.contains('[SPLIT]')) {
      return description.split('[SPLIT]')[0].trim();
    }
    return description;
  }

  String get instructions {
    if (description.contains('[SPLIT]')) {
      return description.split('[SPLIT]')[1].trim();
    }
    return '';
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    
    final categories = ['Dessert', 'Seafood', 'Drinks', 'Japanese', 'Chinese', 'Italian', 'Fast Food'];
    int idValue = json['id'] ?? 0;
    String assignedCategory = categories[idValue % categories.length];

    return Recipe(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['body'] ?? '',
      category: assignedCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'body': '$description \n[CAT]\n $category', 
    };
  }
}