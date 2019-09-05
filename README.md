# parallax_swiper

A swiper widget with parallax effect with support for both swipe directions.

## Installation
Add `parallax_swiper: ^0.0.1` to your `pubspec.yaml` file.
Import it by adding to your file:
```dart
import 'package: parallax_swiper/parallax_swiper.dart'
```
## Use
Create a `ParallaxSwiper` widget and pass the required parameters.

```dart
ParallaxSwiper(
    backgroundWidget: bgWidget,
    foregroundWidgets: <Widget>[fgWidget1, fgWidget2, fgWidget3],
)
```

## Parameters

```dart
ParallaxSwiper(
    backgroundWidget: bgWidget,
    foregroundWidgets: <Widget>[fgWidget1, fgWidget2, fgWidget3],
    alignment: Alignment.center,
    returnDuration: Duration(milliseconds: 1000),
    returnCurve: Curves.easeOut,
    backgroundRoationFactor: 0.001,
    foregroundRotationFactor: 0.001,
    foregroundTranslationFactor: 0.2,
    swiperHeight: 300,
    swiperInitialPage: 0,
    swiperInfiniteSwipe = false,
    swipeDirection: Axis.vertical,
    swiperDuration: Duration(milliseconds: 500),
    swiperCurve: Curves.easeOut,
    onItemChanged: onItemChangeCallback,
    onTap: onTapCallback,
    onDoubleTap: onDoubleTapCallback,
    onLongPress: onLongPressCallback,
)
```

## Example
![horizontal_swipe.gif](example/horizontal_swipe.gif)

![vertical_swipe.gif](example/vertical_swipe.gif)


