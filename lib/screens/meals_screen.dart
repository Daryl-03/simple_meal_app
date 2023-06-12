import 'package:flutter/material.dart';
import 'package:simple_meal_app/models/meal.dart';
import 'package:simple_meal_app/utils/app_layout.dart';
import 'package:simple_meal_app/widgets/meal_item.dart';

import 'meal_detail_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    Key? key,
    this.title,
    required this.meals,
    required this.toggleFavoriteMeal,
  }) : super(key: key);

  final String? title;
  final List<Meal> meals;
  final Function toggleFavoriteMeal;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) =>
            MealDetailScreen(
              meal: meal,
              toggleFavorite: toggleFavoriteMeal,
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayHeight = AppLayout.displayHeightWithoutAppBar(context);
    final displayWidth = AppLayout.displayWidth(context);
    Widget content = SizedBox(
      width: displayWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Nothing found",
            style: Theme
                .of(context)
                .textTheme
                .headlineLarge!
                .copyWith(
              color: Theme
                  .of(context)
                  .colorScheme
                  .onBackground,
            ),
          ),
          SizedBox(
            height: displayHeight * 0.02,
          ),
          Text(
            "Try another category",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge!
                .copyWith(
              color: Theme
                  .of(context)
                  .colorScheme
                  .onBackground,
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty){
      content = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return MealItem(meal: meals[index], onTap: _selectMeal,);
              },
              padding: EdgeInsets.symmetric(
                horizontal: displayWidth * 0.02,
                vertical: displayHeight * 0.01,
              ),
            ),
          ),
        ],
      );
    }

    if(title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            title!,
          ),
        ),
      ),
      body: content
    );
  }
}
