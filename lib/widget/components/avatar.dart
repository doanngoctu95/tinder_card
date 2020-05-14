
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tinder_cards/utils/utils.dart';
import 'package:tinder_cards/widget/components/place_holder_widget.dart';

/// The widget displays avatar of user.
/// Widget can change size of avatar.
class AvatarRadius extends StatelessWidget {
  /// Create the avatar widget.
  ///
  /// [url] link of avatar.
  /// Variable is required.
  ///
  /// [radius] size of avatar icon.
  /// Default value is [mAvatarRadius].
  const AvatarRadius(
      {Key key,
      @required this.url,
      this.isLocked = false,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.borderColor})
      : super(key: key);

  /// Url of avatar.
  final String url;

  final bool isLocked;

  final double width;

  final double height;

  final Color borderColor;

  final EdgeInsetsGeometry padding;

  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(mPaddingSmall),
      margin: margin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: borderColor ?? Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(mCircleRadius),
          child: CachedNetworkImage(
              width: width,
              height: height,
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => PlaceholderWidget(
                    width: width,
                    height: height,
                  ),
              errorWidget: (context, url, error) {
                return Image.asset(
                  'assets/images/avatar_default.png',
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                );
              })),
    );
  }
}
