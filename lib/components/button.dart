import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonTemplate extends StatelessWidget {
  const ButtonTemplate(
      {super.key,
      required this.linkOrText,
      required this.isImage,
      this.functionGot});
  final String linkOrText;
  final bool isImage;
  final functionGot;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
      ),
      onPressed: functionGot,
      child: isImage
          ? SvgPicture.asset(
              linkOrText,
              height: 50,
              width: 50,
            )
          : Text(
              linkOrText,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
    );
  }
}
