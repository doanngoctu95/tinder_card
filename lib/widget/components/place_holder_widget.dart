import 'package:flutter/material.dart';
import 'package:tinder_cards/widget/components/shimmer.dart';

class PlaceholderWidget extends StatefulWidget {
  /// constructor for [PlaceholderWidget]
  /// [width] param to define width of widget
  /// [height] param to define width of widget
  ///
  const PlaceholderWidget({Key key, this.width, this.height}) : super(key: key);

  /// width of this widget.
  final double width;

  /// height of this widget.
  final double height;

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.white,
      ),
    );
  }
}
