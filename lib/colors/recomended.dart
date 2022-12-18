// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:ui';

import 'package:npe_logo_creator/colors/const/color_const.dart';
import 'package:npe_logo_creator/colors/models/color_model.dart';

class AppColorRecomended {
  static List<ColorModel> get getColorModel => [
        ColorModel(
          background: Palette.darkBlue,
          text: Palette.white,
          isDark: true,
        ),
        ColorModel(
          background: const Color(0xFFF96167),
          text: const Color(0xFFFCE77D),
          isDark: false,
        ),
        ColorModel(
          background: const Color(0xFF3C1461),
          text: const Color(0xFFDF668D),
          isDark: true,
        ),
        ColorModel(
          background: const Color(0xFF2F2F2B),
          text: const Color(0xFFF8D343),
          isDark: true,
        ),
        ColorModel(
          background: const Color(0xFFFFECED),
          text: const Color(0xFF2E3A7C),
          isDark: false,
        ),
        ColorModel(
          background: const Color(0xFF90AFEC),
          text: const Color(0xFFFEFFFE),
          isDark: true,
        ),
        ColorModel(
          background: const Color(0xFF4A161F),
          text: const Color(0xFFE2B045),
          isDark: true,
        ),
        ColorModel(
          background: const Color(0xFF9B00FE),
          text: const Color(0xFFFEE8F4),
          isDark: false,
        ),
      ];
}
