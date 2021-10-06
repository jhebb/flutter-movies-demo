import 'package:enum_to_string/enum_to_string.dart';

import 'watch.dart';

class WatchResponse {
  WatchResponse({
    this.streamResults = const [],
    this.rentResults = const [],
    this.buyResults = const [],
    this.error = '',
  });
  List<Watch> streamResults;
  List<Watch> rentResults;
  List<Watch> buyResults;
  String error;

  factory WatchResponse.fromJson(Map<String, dynamic> json) {
    // TODO not sure if we need a try/catch here?
    if (json['results']['CA'] != null) {
      final Map<String, dynamic> data = json['results']['CA'];

      try {
        return WatchResponse(
          streamResults: formatResults(data['flatrate'], WatchType.flatrate),
          rentResults: formatResults(data['rent'], WatchType.rent),
          buyResults: formatResults(data['buy'], WatchType.buy),
        );
      } catch (error) {
        print('watch response broke');
        print(error.toString());

        return WatchResponse(
          error: error.toString(),
        );
      }
    } else {
      return WatchResponse();
    }
  }

  static List<Watch> formatResults(
    List<dynamic>? data,
    WatchType type,
  ) {
    return List<Watch>.from((data ?? []).map((result) {
      result['type'] = EnumToString.convertToString(type);

      return Watch.fromJson(result);
    }));
  }
}
