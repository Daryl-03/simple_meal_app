import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/providers/favorites_provider.dart';
import 'package:simple_meal_app/providers/filters_provider.dart';
import 'package:simple_meal_app/screens/categories_screen.dart';
import 'package:simple_meal_app/screens/filter_screen.dart';
import 'package:simple_meal_app/screens/main_drawer.dart';
import 'package:simple_meal_app/screens/meals_screen.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  var _selectedIndex = 0;

  Future<void> _onScreenSelect(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<FilterType, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String activeTitle = "Pick your category";
    Widget activeScreen = const CategoriesScreen();

    if (_selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
      activeTitle = "Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(
        onScreenSelect: _onScreenSelect,
      ),
      body: SafeArea(child: activeScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: "Favorite"),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
