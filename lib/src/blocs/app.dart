import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:undo/undo.dart';
import 'package:videos/database/database.dart';

class AppBloc extends Cubit<ChangeStack> {
  AppBloc(this.db) : super(db.cs) {
    init();
  }

  final Database db;

  void init() {
    // listen for the category to change. Then display all entries that are in
    // the current category on the home screen.
    ////_currentEntries = _activeCategory.switchMap(db.watchEntriesInCategory);

    // also watch all categories so that they can be displayed in the navigation
    // drawer.
    /*Observable.combineLatest2<List<CategoryWithCount>, Category,
        List<CategoryWithActiveInfo>>(
      db.categoriesWithCount(),
      _activeCategory,
      (allCategories, selected) {
        return allCategories.map((category) {
          final isActive = selected?.id == category.category?.id;

          return CategoryWithActiveInfo(category, isActive);
        }).toList();
      },
    ).listen(_allCategories.add);*/
    emit(db.cs);
  }

}