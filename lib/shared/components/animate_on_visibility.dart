import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimateOnVisibility extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const AnimateOnVisibility({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 450),
    this.offset = 24.0,
  });

  @override
  State<AnimateOnVisibility> createState() => _AnimateOnVisibilityState();
}

class _AnimateOnVisibilityState extends State<AnimateOnVisibility>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _opacity =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _offset = Tween<Offset>(
      begin: Offset(0, widget.offset / 100),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.05) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.key ?? UniqueKey()}-${widget.child.hashCode}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _offset,
          child: widget.child,
        ),
      ),
    );
  }
}
