import 'package:flutter/cupertino.dart';

class ScreenTransitionWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ScreenTransitionWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  ScreenTransitionWrapperState createState() => ScreenTransitionWrapperState();
}

class ScreenTransitionWrapperState extends State<ScreenTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Play enter animation on load
    _controller.forward();
  }
  @override
  void didUpdateWidget(covariant ScreenTransitionWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _controller.forward();
  }

  /// Trigger fade-out and then call a callback (e.g. push route)
  Future<void> triggerExitAnimation(VoidCallback onComplete) async {
    await _controller.reverse();
    onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
