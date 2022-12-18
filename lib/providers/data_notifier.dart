import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:npe_logo_creator/colors/const/color_const.dart';
import 'package:npe_logo_creator/colors/models/color_model.dart';
import 'package:npe_logo_creator/providers/helpers/mode.dart';

class DataNotifier extends ChangeNotifier {
  Mode _mode = Mode.stack;
  String _title = 'NPE Digital';
  ColorModel _colorModel = ColorModel(
    background: Palette.darkBlue,
    text: Palette.white,
    isDark: true,
  );
  double _fontSize = 52;

  double get fontSize => _fontSize;

  Mode get mode => _mode;

  String get title => _title;

  ColorModel get colorModel => _colorModel;

  void changeMode(Mode mode) {
    _mode = mode;
    notifyListeners();
  }

  void changeDarkerMode() {
    _colorModel.changeDarkerMode();

    notifyListeners();
  }

  void changeFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }

  void randomColorPicker() {
    final background =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    final int randomNumber = math.Random().nextInt(2);
    final Color text =
        randomNumber == 0 ? const Color(0xFF000000) : Palette.white;

    _colorModel = ColorModel(
      background: background,
      text: text,
      isDark: text == Palette.white,
    );
    notifyListeners();
  }

  void changeTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void changeColor(ColorModel colorModel) {
    _colorModel = colorModel;
    notifyListeners();
  }
}
