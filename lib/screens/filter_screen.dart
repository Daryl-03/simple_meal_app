import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/providers/filters_provider.dart';
import 'package:simple_meal_app/widgets/filter_parameter.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
            child: Text(
          'Your Filters',
        )),
        actions: [
          TextButton(
            onPressed: (){
              ref.read(filterProvider.notifier).setFilters(null);
            },
            child: Text(
              "Reset",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          )
        ],
      ),
      body: const Column(
        children: [
          FilterParameter(
            title: "Gluten-free",
            subtitle: "Only include gluten-free meals",
            filterType: FilterType.glutenFree,
          ),
          FilterParameter(
            title: "Lactose-free",
            subtitle: "Only include lactose-free meals",
            filterType: FilterType.lactoseFree,
          ),
          FilterParameter(
            title: "Vegetarian",
            subtitle: "Only include vegetarian meals",
            filterType: FilterType.vegetarian,
          ),
          FilterParameter(
            title: "Vegan",
            subtitle: "Only include vegan meals",
            filterType: FilterType.vegan,
          ),
        ],
      ),
    );
  }
}
