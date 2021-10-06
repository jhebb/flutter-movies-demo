class Settings {
  Settings({this.isRatingsForPreviewsEnabled = true});

  final bool isRatingsForPreviewsEnabled;

  Settings copyWith({bool? isRatingsForPreviewsEnabled}) {
    return Settings(
      isRatingsForPreviewsEnabled: isRatingsForPreviewsEnabled ?? this.isRatingsForPreviewsEnabled,
    );
  }
}
