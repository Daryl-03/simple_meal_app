import 'package:flutter/material.dart';
import 'package:simple_meal_app/data/dummy_data.dart';
import 'package:simple_meal_app/utils/app_layout.dart';
import 'package:simple_meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final displayWidth = AppLayout.displayWidth(context);
    final displayHeight = AppLayout.displayHeightWithoutAppBar(context);

    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          child: GridView(
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
                .map((e) => CategoryGridItem(category: e))
                .toList(),
          ),
          builder: (context, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(_animationController),
              child: child,
            );
          }),
    );
  }
}
