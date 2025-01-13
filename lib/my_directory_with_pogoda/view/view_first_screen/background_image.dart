


import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO резина без фиксированных размеров, screen_utils
      height: 813,
      width: 392.7,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              // TODO все строки в константы
              'assets/image/фон.png',
            ),
            fit: BoxFit.fill),
      ),
    );
  }
}
