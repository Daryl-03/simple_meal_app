import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super(
    []
  );

  void toggleFavoriteMeal(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((element) => element != meal).toList();
    } else {
      state = [...state, meal];
    }
  }
}

final favoriteMealsNotifier = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
