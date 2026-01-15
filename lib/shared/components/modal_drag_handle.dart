import 'package:flutter/material.dart';

class ModalDragHandle extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;

  const ModalDragHandle({
    super.key,
    this.color,
    this.width = 40,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
