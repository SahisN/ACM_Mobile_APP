import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteCardsProvider = StateProvider<Set<String>>((ref) => {});

final cardListProvider = Provider<List<String>>((ref) {
  return List.generate(10, (index) => 'Card $index');
});
