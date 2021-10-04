import 'config.dart';

class Utils {
  static String getImageUrl(String path, [int width = 500]) => '${Config.IMAGE_BASE_URL}/w$width$path';
}
