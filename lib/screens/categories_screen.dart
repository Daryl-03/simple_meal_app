import 'package:flutter/material.dart';
import 'package:simple_meal_app/data/dummy_data.dart';
import 'package:simple_meal_app/screens/filter_screen.dart';
import 'package:simple_meal_app/utils/app_layout.dart';
import 'package:simple_meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    Key? key,
    required this.toggleFavoriteMeal,
    required this.filters,
  }) : super(key: key);

  final Function toggleFavoriteMeal;
  final Map<FilterType, bool> filters;

  @override
  Widget build(BuildContext context) {
    final displayWidth = AppLayout.displayWidth(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const FittedBox(
      //       child: Text(
      //     'Pick your category',
      //   )),
      // ),
      body: GridView(
        padding: EdgeInsets.symmetric(
          horizontal: displayWidth * 0.05,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (displayWidth < 600) ? 3 / 2 : 2 / 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          // mainAxisExtent: AppLayout.displayWidth(context)*0.3,
        ),
        children: availableCategories
            .map((e) => CategoryGridItem(
                  category: e,
                  toggleFavoriteMeal: toggleFavoriteMeal,
                  filters: filters,
                ))
            .toList(),
      ),
    );
  }
}
