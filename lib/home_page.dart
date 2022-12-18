// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motion/motion.dart';
import 'package:npe_logo_creator/colors/const/color_const.dart';
import 'package:npe_logo_creator/colors/models/color_model.dart';
import 'package:npe_logo_creator/colors/recomended.dart';
import 'package:npe_logo_creator/providers/data_notifier.dart';
import 'package:npe_logo_creator/providers/helpers/mode.dart';
import 'package:npe_logo_creator/services/data_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final GlobalKey repaintKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'NPE LOGO CREATOR',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Palette.black,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEEF1FB),
      body: Consumer<DataNotifier>(
        builder: (context, state, _) {
          return SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () => state.changeDarkerMode(),
                              child: Motion(
                                shadow: const ShadowConfiguration(
                                  blurRadius: 12.0,
                                  opacity: .2,
                                ),
                                translation: const TranslationConfiguration(
                                  maxOffset: Offset(100, 100),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: RepaintBoundary(
                                    key: repaintKey,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: state.mode == Mode.stack
                                          ? const StackMode()
                                          : const RowMode(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.download,
                                  color: Palette.blue,
                                ),
                                label: const Text(
                                  'Download Logo',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Palette.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  final byte = await captureWidget(
                                    repaintKey.currentContext!,
                                  );

                                  if (byte.isEmpty) {
                                    throw Exception('Capture image failed');
                                  } else {
                                    takePicture(byte);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'Berhasil mendownload gambar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: const [
                          SelectMode(
                            title: 'Stack Mode',
                            mode: Mode.stack,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SelectMode(
                            title: 'Row Mode',
                            mode: Mode.row,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: titleController,
                        onChanged: (e) {
                          state.changeTitle(e);
                        },
                        keyboardType: TextInputType.text,
                        cursorColor: Palette.black,
                        decoration: InputDecoration(
                          hintText: 'NPE Digital',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Palette.white),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Palette.black),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (state.mode == Mode.stack)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Palette.black.withOpacity(.1),
                                blurRadius: 4,
                              )
                            ],
                            color: Palette.white,
                          ),
                          child: Slider(
                            min: 32,
                            max: 72,
                            thumbColor: Palette.blue,
                            activeColor: Palette.darkBlue,
                            value: state.fontSize,
                            onChanged: (value) {
                              state.changeFontSize(value);
                            },
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () => state.randomColorPicker(),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Palette.white,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Palette.black.withOpacity(.1),
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset('assets/icons/dice.svg'),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ...AppColorRecomended.getColorModel
                              .map(
                                (cm) => ColorComboCard(
                                  colorModel: cm,
                                ),
                              )
                              .toList(),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelectMode extends StatelessWidget {
  final Mode mode;
  final String title;
  const SelectMode({
    super.key,
    required this.mode,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DataNotifier>();
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => provider.changeMode(mode),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: provider.mode == mode ? Palette.blue : Palette.white,
          boxShadow: [
            BoxShadow(
              color: Palette.black.withOpacity(.1),
              blurRadius: 4,
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: provider.mode == mode ? Palette.white : Palette.black,
          ),
        ),
      ),
    );
  }
}

class StackMode extends StatelessWidget {
  const StackMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DataNotifier>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: provider.colorModel.background,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/blank.svg',
            width: 180,
            height: 180,
            color: provider.colorModel.isDark
                ? Colors.black.withOpacity(.4)
                : Palette.white.withOpacity(.4),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              provider.title.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                fontSize: provider.fontSize,
                height: 1,
                color: provider.colorModel.text,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowMode extends StatelessWidget {
  const RowMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DataNotifier>();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: provider.colorModel.background,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/blank.svg',
            width: 100,
            height: 100,
            color: provider.colorModel.text,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            provider.title,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(
              fontSize: 28,
              color: provider.colorModel.text,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

class ColorComboCard extends StatelessWidget {
  final ColorModel colorModel;
  const ColorComboCard({
    required this.colorModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<DataNotifier>();
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => colorProvider.changeColor(colorModel),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: colorProvider.colorModel == colorModel
                  ? Palette.blue
                  : Colors.transparent,
            ),
            color: colorModel.isDark ? Palette.white : Palette.black,
            boxShadow: [
              BoxShadow(
                color: Palette.black.withOpacity(.1),
                blurRadius: 4,
              )
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorModel.background,
            ),
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorModel.text,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
