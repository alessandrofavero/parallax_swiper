library parallax_swiper;

import 'package:flutter/widgets.dart';
import 'package:parallax_swiper/src/swiper.dart';

/// Parallax Swiper

class ParallaxSwiper extends StatefulWidget {
  ParallaxSwiper({
    @required this.backgroundWidget,
    @required this.foregroundWidgets,
    this.alignment = Alignment.center,
    this.returnDuration = const Duration(milliseconds: 500),
    this.returnCurve = Curves.easeOut,
    this.backgroundRotationFactor = 0.001,
    this.foregroundRotationFactor = 0.001,
    this.foregroundTranslationFactor = 0.2,
    this.swiperHeight,
    this.swiperInitialPage = 0,
    this.swiperInfiniteSwipe = true,
    this.swipeDirection = Axis.horizontal,
    this.swiperDuration = const Duration(milliseconds: 500),
    this.swiperCurve = Curves.easeOut,
    this.onItemChanged,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  });

  /// The widget in the background of the [ParallaxSwiper]
  final Widget backgroundWidget;

  /// The widgets that are shown in the foreground of the [ParallaxSwipe]
  final List<Widget> foregroundWidgets;

  /// The alignment on the widget stack
  /// Default value [Alignment.center]
  final Alignment alignment;

  /// The duration of the return animation
  /// Default value [Duration(milliseconds: 500)]
  final Duration returnDuration;

  /// The curve of the return animation
  /// Default value [Curves.easeOut]
  final Curve returnCurve;

  /// The background rotation factor
  /// Default value 0.001
  final double backgroundRotationFactor;

  /// The foreground rotation factor
  /// Default value 0.001
  final double foregroundRotationFactor;

  /// The foreground translation factor;
  /// Default value 0.2
  final double foregroundTranslationFactor;

  /// Set the swiper height
  final double swiperHeight;

  /// Set the initial page to show in the [ParallaxSwiper]
  /// Deafault to 0
  final int swiperInitialPage;

  /// Determine if the [ParallaxSwiper] should loop infinitely or be limited to [foregroundWidgets] lenght
  /// Default to true
  final bool swiperInfiniteSwipe;

  /// The axis of the swipe direction
  /// Default to [Axis.horizontal]
  final Axis swipeDirection;

  /// The duration of the swiper animation
  /// Default value [Duration(milliseconds: 500)]
  final Duration swiperDuration;

  /// The curve of the swiper animation
  /// Default value [Curves.easeOut]
  final Curve swiperCurve;

  /// Called when the foreground item displayed changes
  final Function(int index) onItemChanged;

  /// Called when the user tap on the [ParllaxSwiper]
  final Function onTap;

  /// Called when the user double tap on the [ParllaxSwiper]
  final Function onDoubleTap;

  /// Called when the long press on the [ParllaxSwiper]
  final Function onLongPress;

  _ParallaxSwiperState createState() => _ParallaxSwiperState();
}

class _ParallaxSwiperState extends State<ParallaxSwiper>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _returnAnimation;
  AnimationController _returnController;

  Offset _offset = Offset.zero;

  // Horizontal drag details
  DragStartDetails _startHorizontalDragDetails;
  DragUpdateDetails _updateHorizontalDragDetail;

  //Vertical drag details
  DragStartDetails _startVerticalDragDetails;
  DragUpdateDetails _updateVerticalDragDetail;

  @override
  void initState() {
    super.initState();
    _returnController =
        AnimationController(duration: widget.returnDuration, vsync: this);
    _returnController.addListener(() {
      setState(() {
        _offset = _returnAnimation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // The swiper to be used in the foreground
    Swiper _swiper = Swiper(
      children: widget.foregroundWidgets,
      height: widget.swiperHeight ?? null,
      initialPage: widget.swiperInitialPage,
      infiniteScroll: widget.swiperInfiniteSwipe,
      swipeDirection: widget.swipeDirection,
      onPageChanged: widget.onItemChanged ?? null,
    );

    // The foreground of the widget
    var _foreground = Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(widget.foregroundRotationFactor * _offset.dy)
        ..rotateY(-widget.foregroundRotationFactor * _offset.dx)
        ..translate(widget.foregroundTranslationFactor * _offset.dx,
            widget.foregroundTranslationFactor * _offset.dy),
      alignment: FractionalOffset.center,
      child: _swiper,
    );

    // The background of the widget
    var _background = Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(widget.backgroundRotationFactor * _offset.dy)
        ..rotateY(-widget.backgroundRotationFactor * _offset.dx),
      alignment: FractionalOffset.center,
      child: widget.backgroundWidget,
    );

    return GestureDetector(
      child: Stack(
        alignment: widget.alignment,
        children: <Widget>[
          _background,
          _foreground,
        ],
      ),

      // Horizontal drag input
      onHorizontalDragStart: (details) {
        _startHorizontalDragDetails = details;
      },
      onHorizontalDragUpdate: widget.swipeDirection == Axis.horizontal
          ? (details) {
              _updateHorizontalDragDetail = details;
              setState(() {
                _offset += details.delta;
              });
            }
          : null,
      onHorizontalDragEnd: widget.swipeDirection == Axis.horizontal
          ? (details) {
              double dx = _updateHorizontalDragDetail.globalPosition.dx -
                  _startHorizontalDragDetails.globalPosition.dx;
              if (dx > 0) {
                _swiper.moveToPreviusPage(
                    duration: widget.swiperDuration, curve: widget.swiperCurve);
              } else {
                _swiper.moveToNextPage(
                    duration: widget.swiperDuration, curve: widget.swiperCurve);
              }

              _runReturnAnimation();
            }
          : null,

      // Vertical drag input
      onVerticalDragStart: (details) {
        _startVerticalDragDetails = details;
      },
      onVerticalDragUpdate: widget.swipeDirection == Axis.vertical
          ? (details) {
              _updateVerticalDragDetail = details;
              setState(() {
                _offset += details.delta;
              });
            }
          : null,
      onVerticalDragEnd: widget.swipeDirection == Axis.vertical
          ? (details) {
              double dy = _updateVerticalDragDetail.globalPosition.dy -
                  _startVerticalDragDetails.globalPosition.dy;

              if (dy > 0) {
                _swiper.moveToPreviusPage(
                    duration: widget.swiperDuration, curve: widget.swiperCurve);
              } else {
                _swiper.moveToNextPage(
                    duration: widget.swiperDuration, curve: widget.swiperCurve);
              }

              _runReturnAnimation();
            }
          : null,

      // Other inputs
      onDoubleTap: widget.onLongPress ?? null,
      onTap: widget.onTap ?? null,
      onLongPress: widget.onLongPress ?? null,
    );
  }

  @override
  void dispose() {
    _returnController.dispose();
    super.dispose();
  }

  /// Animate the widget to return to the center position
  void _runReturnAnimation() {
    final Animatable<Offset> _tween =
        Tween<Offset>(begin: _offset, end: Offset.zero)
            .chain(CurveTween(curve: widget.returnCurve));
    _returnAnimation = _returnController.drive(_tween);
    _returnController.reset();
    _returnController.forward();
  }
}
