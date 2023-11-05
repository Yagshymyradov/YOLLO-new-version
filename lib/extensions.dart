
import 'package:flutter/material.dart';

extension Keyboard on Never {
  static void hide() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
