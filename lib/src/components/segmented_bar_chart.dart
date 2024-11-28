import 'dart:math';

import 'package:flutter/material.dart';

class Segment {
  final double fractionalValue;
  final Color color;

  const Segment({required this.fractionalValue, required this.color});

  double get value => min(max(fractionalValue, 0.0), 1);
}

class SegmentedBarChart extends StatelessWidget {
  static const double verySmallNumber = 0.00000001;

  final List<Segment> data;
  final double gap;
  final Color gapColor;
  final double height;
  final Radius borderRadius;
  final String Function(double value)? tooltipBuilder;

  const SegmentedBarChart({
    super.key,
    required this.data,
    this.gap = .02,
    this.gapColor = Colors.transparent,
    this.height = 10,
    this.borderRadius = const Radius.circular(500),
    this.tooltipBuilder,
  });

  Iterable<MapEntry<int, Segment>> get _dataAsMap => data.asMap().entries;

  AnimatedFractionallySizedBox _getSegment(double width, bool isLast) {
    return AnimatedFractionallySizedBox(
      heightFactor: 1,
      widthFactor: width,
      duration: Duration(milliseconds: 250),
      child: isLast || gap == 0
          ? null
          : Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: height,
                width: gap,
                child: ColoredBox(color: gapColor),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _dataAsMap.map(
        (e) {
          bool isFirst = !_dataAsMap.any((x) {
            return x.key < e.key && x.value.value > 0;
          });
          bool isLast = !_dataAsMap.any((x) {
            return x.key > e.key && x.value.value > 0;
          });

          return Container(
            decoration: BoxDecoration(
              color: data[e.key].color,
              borderRadius: BorderRadius.horizontal(
                left: isFirst ? borderRadius : Radius.zero,
                right: isLast ? borderRadius : Radius.zero,
              ),
            ),
            height: height,
            child: tooltipBuilder != null
                ? Tooltip(
                    message: tooltipBuilder!(e.value.value),
                    triggerMode: TooltipTriggerMode.tap,
                    child: _getSegment(e.value.value, isLast),
                  )
                : _getSegment(e.value.value, isLast),
          );
        },
      ).toList(),
    );
  }
}
