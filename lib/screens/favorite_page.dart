import 'package:acm_app/provider/favorite_event_provider.dart';
import 'package:acm_app/widget/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteEvents = ref.watch(favoriteEventProvider);

    // if favoriteEvents length is 0, then there is no events added to favorites
    if (favoriteEvents.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: const Center(
          child: Text('Favorites empty...'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Column(
            children: favoriteEvents
                .map(
                  (event) => EventCard(event),
                )
                .toList()),
      ),
    );
  }
}
