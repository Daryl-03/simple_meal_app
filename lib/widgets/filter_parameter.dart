import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meal_app/providers/filters_provider.dart';

class FilterParameter extends ConsumerWidget {
  const FilterParameter({
    Key? key,
    required this.title,
    this.subtitle,
    required this.filterType,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final FilterType filterType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);

    return SwitchListTile(
      value: filter[filterType]!,
      onChanged: (newValue){
        ref.read(filterProvider.notifier).setFilter(filterType, newValue);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        subtitle ?? "",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
