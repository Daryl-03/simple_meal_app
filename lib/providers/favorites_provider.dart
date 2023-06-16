import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super(
    []
  );

  bool toggleFavoriteMeal(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((element) => element != meal).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  bool isFavoriteMeal(Meal meal) {
    return state.contains(meal);
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});