enum MovieType { popular, now_playing, top_rated, upcoming }

extension MovieTypeExtension on MovieType {
  String get value => toString().split('.').last;

  String get name {
    switch (this) {
      case MovieType.popular:
        return 'Popular';
      case MovieType.now_playing:
        return 'Now Playing';
      case MovieType.top_rated:
        return 'Top Rated';
      case MovieType.upcoming:
        return 'Upcoming';
      default:
        return 'Unknown';
    }
  }
}
