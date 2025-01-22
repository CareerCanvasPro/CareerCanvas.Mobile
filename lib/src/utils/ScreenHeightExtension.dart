import 'package:flutter/widgets.dart';

extension ScreenHeightExtension on BuildContext {
  double get screenHeight {
    return MediaQuery.of(this).size.height;
  }
}

extension ScreenWidthExtension on BuildContext {
  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }
}
