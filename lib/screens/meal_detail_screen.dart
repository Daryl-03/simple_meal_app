import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/models/meal.dart';
import 'package:simple_meal_app/providers/favorites_provider.dart';
import 'package:simple_meal_app/utils/app_layout.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  final Meal meal;

  void _showInfoMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        width: AppLayout.displayWidth(context) * 0.8,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        dismissDirection: DismissDirection.endToStart,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayWidth = AppLayout.displayWidth(context);
    final displayHeight = AppLayout.displayHeightWithoutAppBar(context);
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              var isAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleFavoriteMeal(meal);
              _showInfoMessage(
                  isAdded ? "Added to favorites" : "Removed from favorites",
                  context);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(
                    begin: 0.85,
                    end: 1.0
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                fit: BoxFit.cover,
                height: (displayHeight > 600)
                    ? displayHeight * 0.3
                    : displayHeight * 0.8,
                width: displayWidth,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
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
