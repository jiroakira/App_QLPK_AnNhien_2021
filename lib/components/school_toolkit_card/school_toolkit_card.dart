import 'package:flutter/material.dart';
import 'package:medapp/components/colors/school_toolkit_colors.dart';

class SchoolToolkitCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color activeColor;
  final bool active;
  final Duration animationDuration;
  final Alignment alignment;
  final double width;
  final double height;
  final bool showShadow;
  final EdgeInsets margin;

  const SchoolToolkitCard({
    Key key,
    this.child,
    this.backgroundColor = SchoolToolkitColors.blueGrey,
    this.activeColor = SchoolToolkitColors.blue,
    this.active = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.showShadow = false,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: EdgeInsets.all(
        15,
      ),
      margin: margin,
      curve: Curves.ease,
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        color: active ? activeColor : backgroundColor,
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  blurRadius: 15,
                  color: SchoolToolkitColors.blackShadow,
                  offset: Offset(
                    0,
                    15,
                  ),
                  spreadRadius: 13,
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
