import 'package:enum_to_string/enum_to_string.dart';

import '../utils.dart';

enum WatchType {
  flatrate,
  rent,
  buy,
  unknown,
}

class Watch {
  Watch({
    required this.providerName,
    required this.providerId,
    required this.logoPath,
    required this.displayPriority,
    required this.type,
  });

  final String providerName;
  final int providerId;
  final String logoPath;
  final int displayPriority;
  final WatchType type;

  String get logoPathUrl => Utils.getImageUrl(logoPath, 500);

  factory Watch.fromJson(Map<String, dynamic> json) {
    return Watch(
      providerName: json['provider_name'],
      providerId: json['provider_id'],
      logoPath: json['logo_path'],
      displayPriority: json['display_priority'],
      type: EnumToString.fromString(WatchType.values, json['type']) ?? WatchType.unknown,
    );
  }

  @override
  String toString() {
    return 'Watch(providerName: $providerName, providerId: $providerId, logoPath: $logoPath, displayPriority: $displayPriority, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Watch &&
        other.providerName == providerName &&
        other.providerId == providerId &&
        other.logoPath == logoPath &&
        other.displayPriority == displayPriority &&
        other.type == type;
  }

  @override
  int get hashCode {
    return providerName.hashCode ^ providerId.hashCode ^ logoPath.hashCode ^ displayPriority.hashCode ^ type.hashCode;
  }
}
