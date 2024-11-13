import 'package:flutter/material.dart';

class FutureBuilderWithCircularProgress<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T? data) dataBuilder;
  final Widget Function(BuildContext context, Object? error) errorBuilder;

  const FutureBuilderWithCircularProgress(
      {super.key,
      required this.future,
      required this.dataBuilder,
      required this.errorBuilder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        } else {
          if (snapshot.hasError) {
            return errorBuilder(context, snapshot.error);
          } else {
            return dataBuilder(context, snapshot.data);
          }
        }
      },
    );
  }
}
