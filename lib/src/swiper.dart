import 'package:flutter/widgets.dart';

class Swiper extends StatelessWidget {
  Swiper({
    @required this.children,
    this.height,
    this.initialPage,
    int realPage = 1000,
    this.infiniteScroll,
    this.swipeDirection,
    this.onPageChanged,
  })  : this.realPage = infiniteScroll ? realPage + initialPage : initialPage,
        this.pageController = PageController(
            initialPage: infiniteScroll ? realPage + initialPage : initialPage);

  /// The list of widgets to be displayed
  final List<Widget> children;

  /// Set the slider height
  final double height;

  /// The initial page to show in the [Swiper]
  final int initialPage;

  /// The actual index of the of the [Swiper]
  final int realPage;

  /// Determine if the [Swiper] should loop infinitely or be limited to [children] lenght
  final bool infiniteScroll;

  /// The axis of the swipe direction
  final Axis swipeDirection;

  /// Called when the page changed
  final Function(int index) onPageChanged;

  /// The controller for the [Swiper]
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != null ? height : null,
      child: IgnorePointer(
        child: PageView.builder(
          controller: pageController,
          scrollDirection: swipeDirection,
          itemCount: infiniteScroll ? null : children.length,
          onPageChanged: (index) {
            int currentPage =
                _getRealIndex(index + initialPage, realPage, children.length);
            if (onPageChanged != null) {
              onPageChanged(currentPage);
            }
          },
          itemBuilder: (context, i) {
            final int index =
                _getRealIndex(i + initialPage, realPage, children.length);
            return children[index];
          },
        ),
      ),
    );
  }

  /// Change the [Swiper] to the next page
  /// The animation last for the given duration and follows the given curve
  Future<void> moveToNextPage(
      {Duration duration, Curve curve = Curves.easeOut}) {
    return pageController.nextPage(duration: duration, curve: curve);
  }

  /// Change the [Swiper] to the previous page
  /// The animation last for the given duration and follows the given curve
  Future<void> moveToPreviusPage({Duration duration, Curve curve}) {
    return pageController.previousPage(duration: duration, curve: curve);
  }
}

// HELPERS
int _getRealIndex(int position, int base, int length) {
  final int offset = position - base;
  final result = offset % length;
  return result < 0 ? length + result : result;
}
