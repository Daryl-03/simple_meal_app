import 'package:flutter/material.dart';

class FilterParameter extends StatelessWidget {
  const FilterParameter({
    Key? key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: (newValue){
        onChanged(newValue);
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
