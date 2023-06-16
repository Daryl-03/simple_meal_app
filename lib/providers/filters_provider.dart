import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterType {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

const kInitialFilters = {
  FilterType.glutenFree: false,
  FilterType.lactoseFree: false,
  FilterType.vegetarian: false,
  FilterType.vegan: false,
};

class FilterNotifier extends StateNotifier<Map<FilterType, bool>> {
  FilterNotifier() : super(kInitialFilters);

  void setFilter(FilterType filterType, bool value) {
    state = {
      ...state,
      filterType: value,
    };
  }

  void setFilters(Map<FilterType, bool>? filters) {
    state = filters ?? kInitialFilters;
  }

}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<FilterType, bool>>((ref) {
  return FilterNotifier();
});
