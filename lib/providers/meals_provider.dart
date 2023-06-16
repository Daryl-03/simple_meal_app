
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/data/dummy_data.dart';
import 'package:simple_meal_app/models/category.dart';
import 'package:simple_meal_app/providers/filters_provider.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});

final availableMealsProvider = Provider.family((ref, String categoryId) {
  final meals = ref.watch(mealsProvider);
  return meals.where((element) => element.categories.contains(categoryId)).toList();
});

final filteredMealsProvider = Provider.family((ref, String categoryId) {
  final filters = ref.watch(filterProvider);
  final meals = ref.watch(availableMealsProvider(categoryId));

  return meals
      .where((element) =>
          (!filters[FilterType.glutenFree]! || element.isGlutenFree) &&
          (!filters[FilterType.vegan]! || element.isVegan) &&
          (!filters[FilterType.vegetarian]! || element.isVegetarian) &&
          (!filters[FilterType.lactoseFree]! || element.isLactoseFree))
      .toList();
});
