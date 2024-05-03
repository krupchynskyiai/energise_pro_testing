import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child:
          LoadingAnimationWidget.discreteCircle(color: Colors.white, size: 100),
    );
  }
}
