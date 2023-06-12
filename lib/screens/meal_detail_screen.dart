import 'package:flutter/material.dart';
import 'package:simple_meal_app/models/meal.dart';
import 'package:simple_meal_app/utils/app_layout.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({
    Key? key,
    required this.meal,
    required this.toggleFavorite
  }) : super(key: key);

  final Meal meal;
  final Function toggleFavorite;

  @override
  Widget build(BuildContext context) {
    final displayWidth = AppLayout.displayWidth(context);
    final displayHeight = AppLayout.displayHeightWithoutAppBar(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: (){
              toggleFavorite(meal);
            },
            icon: const Icon(Icons.star_border),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              height: (displayHeight > 600)
                  ? displayHeight * 0.3
                  : displayHeight * 0.8,
              width: displayWidth,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            SizedBox(height: displayHeight * 0.02),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: displayHeight * 0.02),
            for (var ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            SizedBox(height: displayHeight * 0.02),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: displayHeight * 0.02),
            for (var step in meal.steps)
              Padding(
                padding: EdgeInsets.only(
                  bottom: displayHeight * 0.03,
                  left: displayWidth * 0.1,
                  right: displayWidth * 0.1,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
