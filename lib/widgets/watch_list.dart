import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/watch.dart';
import '../providers/watch.dart';

class WatchList extends ConsumerWidget {
  const WatchList({required this.id, Key? key}) : super(key: key);

  final num id;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final watchFeed = watch(watchProvider(id));

    return watchFeed.maybeWhen(
      orElse: () => const Center(child: CircularProgressIndicator()),
      data: (watchData) {
        return CustomScrollView(
          slivers: [
            _WatchListTitle(
              results: watchData.streamResults,
              title: 'Stream',
            ),
            _WatchListGrid(
              results: watchData.streamResults,
            ),
            _WatchListTitle(
              results: watchData.rentResults,
              title: 'Rent',
            ),
            _WatchListGrid(
              results: watchData.rentResults,
            ),
            _WatchListTitle(
              results: watchData.buyResults,
              title: 'Buy',
            ),
            _WatchListGrid(
              results: watchData.buyResults,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(
                child: Text('Data provided by JustWatch', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10))),
          ],
        );
      },
    );
  }
}

class _WatchListTitle extends StatelessWidget {
  const _WatchListTitle({required this.title, required this.results, Key? key}) : super(key: key);

  final String title;
  final List<Watch> results;

  @override
  Widget build(BuildContext context) {
    if (results.isNotEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }

    return const SliverToBoxAdapter(child: SizedBox());
  }
}

class _WatchListGrid extends StatelessWidget {
  const _WatchListGrid({required this.results, Key? key}) : super(key: key);

  final List<Watch> results;

  @override
  Widget build(BuildContext context) {
    if (results.isNotEmpty) {
      return SliverGrid.count(
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 4,
        childAspectRatio: 1 / 1,
        children: [...results.map((result) => Image(image: NetworkImage(result.logoPathUrl)))],
      );
    }

    return const SliverToBoxAdapter();
  }
}
