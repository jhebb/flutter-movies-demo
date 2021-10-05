import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/credits.dart';

class CastList extends ConsumerWidget {
  const CastList({this.id = 0, Key? key}) : super(key: key);

  final num id;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final castData = watch(castProvider(id));

    return Container(
      child: castData.maybeWhen(
        orElse: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Text('Sorry, could not load cast'),
        data: (cast) => ListView.builder(
          itemCount: cast.length,
          itemBuilder: (BuildContext context, int index) {
            final castItem = cast[index];

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(castItem.name),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    castItem.character,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
