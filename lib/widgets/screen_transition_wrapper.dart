import 'package:flutter/cupertino.dart';

/// A widget that wraps its child with a fade-in and fade-out transition animation.
///
/// When inserted into the widget tree, the child fades in from transparent to fully visible.
/// You can trigger a fade-out animation programmatically by calling [triggerExitAnimation].
///
/// Typically used to animate screen transitions with fade effects.
///
/// Example usage:
/// ```dart
/// ScreenTransitionWrapper(
///   child: YourScreenWidget(),
/// )
/// ```
///
/// To trigger fade-out animation before navigating away:
/// ```dart
/// final key = GlobalKey<ScreenTransitionWrapperState>();
///
/// ScreenTransitionWrapper(
///   key: key,
///   child: YourScreenWidget(),
/// );
///
/// // Later...
/// key.currentState?.triggerExitAnimation(() {
///   Navigator.of(context).push(...);
/// });
/// ```
class ScreenTransitionWrapper extends StatefulWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The duration of the fade-in and fade-out animations.
  /// Defaults to 600 milliseconds.
  final Duration duration;

  /// Creates a [ScreenTransitionWrapper].
  const ScreenTransitionWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  ScreenTransitionWrapperState createState() => ScreenTransitionWrapperState();
}

/// The state for [ScreenTransitionWrapper], manages animation lifecycle.
class ScreenTransitionWrapperState extends State<ScreenTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with the specified duration.
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Define a Tween animation from 0 (transparent) to 1 (fully visible)
    // with a smooth ease-in-out curve.
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the fade-in animation immediately after the widget is inserted.
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ScreenTransitionWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset and replay the animation if the widget updates with new properties.
    _controller.reset();
    _controller.forward();
  }

  /// Triggers the fade-out animation and calls [onComplete] callback after it finishes.
  ///
  /// Useful for animating screen exit transitions before navigating away.
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
    // Dispose animation controller to free resources.
    _controller.dispose();
    super.dispose();
  }
}
