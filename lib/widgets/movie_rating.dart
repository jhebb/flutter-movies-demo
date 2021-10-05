import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {
  const MovieRating(this.average, {this.extended = true, Key? key}) : super(key: key);

  final num average;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 18,
          color: Colors.yellow,
        ),
        const SizedBox(width: 4),
        Text('$average${extended ? ' / 10' : ''}'),
      ],
    );
  }
}
