import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/dimentions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({
    Key? key,
    required this.webScreenLayout, // remove space
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // web screen
          return webScreenLayout;
        } else {
          // mobile screen
          return mobileScreenLayout;
        }
      },
    );
  }
}
