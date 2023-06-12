import 'package:flutter/material.dart';
import 'package:simple_meal_app/models/meal.dart';
import 'package:simple_meal_app/screens/categories_screen.dart';
import 'package:simple_meal_app/screens/filter_screen.dart';
import 'package:simple_meal_app/screens/main_drawer.dart';
import 'package:simple_meal_app/screens/meals_screen.dart';
import 'package:simple_meal_app/utils/app_layout.dart';

const kInitialFilters = {
  FilterType.vegan: false,
  FilterType.vegetarian: false,
  FilterType.glutenFree: false,
  FilterType.lactoseFree: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  var _selectedIndex = 0;
  final _favoriteMeals = <Meal>[];
  var _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
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

  Future<void> _onScreenSelect(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context)
          .push<Map<FilterType, bool>>(MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                    filters: _selectedFilters,
                  )));

      if (result != null) {
        setState(() {
          _selectedFilters = result;
        });
      }
    }
  }

  bool _toggleFavoriteMeal(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      _favoriteMeals.remove(meal);
      _showInfoMessage("Removed from favorites");
    } else {
      _favoriteMeals.add(meal);
      _showInfoMessage("Added to favorites");
    }
    setState(() {
      _favoriteMeals;
    });
    return _favoriteMeals.contains(meal);
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String activeTitle = "Pick your category";
    Widget activeScreen = CategoriesScreen(
      toggleFavoriteMeal: _toggleFavoriteMeal,
      filters: _selectedFilters,
    );

    if (_selectedIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        toggleFavoriteMeal: _toggleFavoriteMeal,
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
