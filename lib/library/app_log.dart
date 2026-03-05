// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart' show kReleaseMode;
import '../config/constants.dart';

appPrint(log) {
  if (!kReleaseMode || isDevelopment()) {
    print(log);
  }
}
