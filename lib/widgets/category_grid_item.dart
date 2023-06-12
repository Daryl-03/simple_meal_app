import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/providers/meals_provider.dart';

import 'package:simple_meal_app/data/dummy_data.dart';
import 'package:simple_meal_app/models/category.dart';
import 'package:simple_meal_app/screens/filter_screen.dart';
import 'package:simple_meal_app/screens/meals_screen.dart';
import 'package:simple_meal_app/utils/app_layout.dart';

class CategoryGridItem extends ConsumerWidget {
  final Category category;
  final Function toggleFavoriteMeal;
  final Map<FilterType, bool> filters;

  const CategoryGridItem({
    Key? key,
    required this.category,
    required this.toggleFavoriteMeal,
    required this.filters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final displayWidth = AppLayout.displayWidth(context);
    final meals = ref.watch(mealsProvider);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MealsScreen(
            title: category.title,
            meals: meals
                .where((element) => element.categories.contains(category.id) &&
                    (!filters[FilterType.glutenFree]! ||
                            element.isGlutenFree) &&
                        (!filters[FilterType.vegan]! ||
                            element.isVegan) &&
                        (!filters[FilterType.vegetarian]! ||
                            element.isVegetarian) &&
                        (!filters[FilterType.lactoseFree]! ||
                            element.isLactoseFree))
                .toList(),
            toggleFavoriteMeal: toggleFavoriteMeal,
          );
        }));
      },
      splashColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
      borderRadius: BorderRadius.circular(displayWidth * 0.03),
      child: Container(
        padding: EdgeInsets.only(
          top: displayWidth * 0.03,
          left: displayWidth * 0.03,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(displayWidth * 0.03),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FittedBox(
          alignment: Alignment.topLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: (displayWidth > 600)
                      ? 30
                      : Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
          ),
        ),
      ),
    );
  }
}
