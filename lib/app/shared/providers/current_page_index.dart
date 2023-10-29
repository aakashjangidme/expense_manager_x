import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_page_index.g.dart';

@riverpod
class CurrentPageIndex extends _$CurrentPageIndex {
  @override
  int build() => 0;

  void newIndex(int newIndex) => state = newIndex;
}
