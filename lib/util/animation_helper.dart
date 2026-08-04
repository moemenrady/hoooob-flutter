import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

/// Fresh animation helper using only animate_do widgets
class AnimationHelper {
  AnimationHelper._();

  static const Duration _fast = Duration(milliseconds: 300);
  static const Duration _medium = Duration(milliseconds: 600);
  static const Duration _slow = Duration(milliseconds: 900);
  static const Duration _stagger = Duration(milliseconds: 150);

  static Widget titleAnimation({required Widget child, Duration? delay}) {
    return FadeIn(
      duration: _medium,
      delay: delay ?? Duration.zero,
      child: ZoomIn(
        duration: _medium,
        child: FlipInY(
          duration: _medium,
          child: child,
        ),
      ),
    );
  }

  static Widget subtitleAnimation({required Widget child, Duration? delay}) {
    return FadeIn(
      duration: _medium,
      delay: delay ?? Duration(milliseconds: 150),
      child: SlideInUp(
        duration: _medium,
        child: Swing(
          duration: _medium,
          child: child,
        ),
      ),
    );
  }

  static Widget sectionAnimation({required Widget child, Duration? delay}) {
    return FadeIn(
      duration: _slow,
      delay: delay ?? Duration(milliseconds: 300),
      child: BounceIn(
        duration: _slow,
        child: FlipInY(
          duration: _slow,
          child: child,
        ),
      ),
    );
  }

  static Widget cardAnimation({
    required Widget child,
    required int index,
    Duration? customDelay,
  }) {
    final delay =
        customDelay ?? Duration(milliseconds: index * _stagger.inMilliseconds);
    return FadeIn(
      duration: _medium,
      delay: delay,
      child: SlideInUp(
        duration: _medium,
        delay: delay,
        child: FlipInY(
          duration: _slow,
          child: ZoomIn(
            duration: _medium,
            child: child,
          ),
        ),
      ),
    );
  }

  static Widget leftCardAnimation({
    required Widget child,
    required int index,
    Duration? customDelay,
  }) {
    final delay =
        customDelay ?? Duration(milliseconds: index * _stagger.inMilliseconds);
    return FadeInLeft(
      duration: _medium,
      delay: delay,
      child: SlideInLeft(
        duration: _medium,
        child: FlipInX(
          duration: _slow,
          child: child,
        ),
      ),
    );
  }

  static Widget rightCardAnimation({
    required Widget child,
    required int index,
    Duration? customDelay,
  }) {
    final delay =
        customDelay ?? Duration(milliseconds: index * _stagger.inMilliseconds);
    return FadeInRight(
      duration: _medium,
      delay: delay,
      child: SlideInRight(
        duration: _medium,
        child: FlipInX(
          duration: _slow,
          child: child,
        ),
      ),
    );
  }

  static Widget buttonAnimation({
    required Widget child,
    required bool isVisible,
    Duration? duration,
  }) {
    return AnimatedScale(
      scale: isVisible ? 1.2 : 0.0,
      duration: duration ?? _fast,
      curve: Curves.elasticOut,
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: duration ?? _fast,
        child: child,
      ),
    );
  }

  static Widget fadeIn({required Widget child, Duration? duration, Duration? delay}) {
    return FadeIn(
      duration: duration ?? _fast,
      delay: delay ?? Duration.zero,
      child: Pulse(child: child, duration: _fast),
    );
  }

  static Widget slideUp({required Widget child, Duration? duration, Duration? delay}) {
    return SlideInUp(
      duration: duration ?? _medium,
      delay: delay ?? Duration.zero,
      child: Swing(child: child, duration: _medium),
    );
  }

  static Widget slideDown({required Widget child, Duration? duration, Duration? delay}) {
    return SlideInDown(
      duration: duration ?? _medium,
      delay: delay ?? Duration.zero,
      child: BounceIn(child: child, duration: _medium),
    );
  }

  static Widget slideLeft({required Widget child, Duration? duration, Duration? delay}) {
    return SlideInLeft(
      duration: duration ?? _medium,
      delay: delay ?? Duration.zero,
      child: Swing(child: child, duration: _medium),
    );
  }

  static Widget slideRight({required Widget child, Duration? duration, Duration? delay}) {
    return SlideInRight(
      duration: duration ?? _medium,
      delay: delay ?? Duration.zero,
      child: Swing(child: child, duration: _medium),
    );
  }

  static Widget bounceInUp({required Widget child, Duration? duration, Duration? delay}) {
    return BounceInUp(
      duration: duration ?? _slow,
      delay: delay ?? Duration.zero,
      child: ZoomIn(child: child, duration: _medium),
    );
  }

  static Widget bounceInDown({required Widget child, Duration? duration, Duration? delay}) {
    return BounceInDown(
      duration: duration ?? _slow,
      delay: delay ?? Duration.zero,
      child: ZoomIn(child: child, duration: _medium),
    );
  }

  static Widget bounceInLeft({required Widget child, Duration? duration, Duration? delay}) {
    return BounceInLeft(
      duration: duration ?? _slow,
      delay: delay ?? Duration.zero,
      child: ZoomIn(child: child, duration: _medium),
    );
  }

  static Widget bounceInRight({required Widget child, Duration? duration, Duration? delay}) {
    return BounceInRight(
      duration: duration ?? _slow,
      delay: delay ?? Duration.zero,
      child: ZoomIn(child: child, duration: _medium),
    );
  }

  static Widget custom({
    required Widget child,
    Duration? duration,
    Duration? delay,
    String? type,
  }) {
    switch (type?.toLowerCase()) {
      case 'fadein':
        return fadeIn(child: child, duration: duration, delay: delay);
      case 'fadeindown':
        return slideDown(child: child, duration: duration, delay: delay);
      case 'fadeinup':
        return slideUp(child: child, duration: duration, delay: delay);
      case 'fadeinleft':
        return slideLeft(child: child, duration: duration, delay: delay);
      case 'fadeinright':
        return slideRight(child: child, duration: duration, delay: delay);
      case 'bounceinup':
        return bounceInUp(child: child, duration: duration, delay: delay);
      case 'bounceindown':
        return bounceInDown(child: child, duration: duration, delay: delay);
      case 'bounceinleft':
        return bounceInLeft(child: child, duration: duration, delay: delay);
      case 'bounceinright':
        return bounceInRight(child: child, duration: duration, delay: delay);
      default:
        return ZoomIn(child: child, duration: _medium);
    }
  }
  static Widget dialogAnimation({
  required Widget child,
  Duration? duration,
}) {
  return FadeIn(
    duration: duration ?? _medium,
    child: ElasticIn(
      duration: duration ?? _medium,
      child: Swing(
        duration: duration ?? _medium,
        child: child,
      ),
    ),
  );
}
}