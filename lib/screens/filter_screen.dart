import 'package:flutter/material.dart';
import 'package:simple_meal_app/widgets/filter_parameter.dart';

enum FilterType {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
    required this.filters,
  }) : super(key: key);

  final Map<FilterType, bool> filters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<FilterType, bool> _filters = {};

  @override
  void initState() {
    _filters = Map.from(widget.filters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filterList = {
      FilterType.glutenFree: FilterParameter(
        title: "Gluten-free",
        subtitle: "Only include gluten-free meals",
        value: _filters[FilterType.glutenFree] ?? false,
        onChanged: (newValue) {
          setState(() {
            _filters[FilterType.glutenFree] = newValue;
          });
        },
      ),
      FilterType.lactoseFree: FilterParameter(
        title: "Lactose-free",
        subtitle: "Only include lactose-free meals",
        value: _filters[FilterType.lactoseFree] ?? false,
        onChanged: (newValue) {
          setState(() {
            _filters[FilterType.lactoseFree] = newValue;
          });
        },
      ),
      FilterType.vegetarian: FilterParameter(
        title: "Vegetarian",
        subtitle: "Only include vegetarian meals",
        value: _filters[FilterType.vegetarian] ?? false,
        onChanged: (newValue) {
          setState(() {
            _filters[FilterType.vegetarian] = newValue;
          });
        },
      ),
      FilterType.vegan: FilterParameter(
        title: "Vegan",
        subtitle: "Only include vegan meals",
        value: _filters[FilterType.vegan] ?? false,
        onChanged: (newValue) {
          setState(() {
            _filters[FilterType.vegan] = newValue;
          });
        },
      )
    };

    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
            child: Text(
          'Your Filters',
        )),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // var filterMap =
          //     filterList.map((key, value) => MapEntry(key, value.value));
          Navigator.of(context).pop(_filters);
          return false;
        },
        child: Column(children: filterList.values.toList()),
      ),
    );
  }
}
