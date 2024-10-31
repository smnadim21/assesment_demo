import 'dart:developer';

import 'package:flutter/material.dart';

typedef FutureWidgetBuilder<T> = Widget Function(T? data);
typedef FutureErrorBuilder<T> = Widget Function(
    AsyncSnapshot<T> snapshot, String reason);

class FutureWidget<T> extends StatelessWidget {
  final Future<T>? future;
  final T? initialData;
  final Widget? shimmer;
  final Widget? noData;
  final Widget? error;
  final Duration? timeout;
  final FutureWidgetBuilder<T> buildWidget;
  final FutureErrorBuilder<T>? errorWidget;

  const FutureWidget({
    super.key,
    this.future,
    this.initialData,
    this.shimmer,
    this.noData,
    this.timeout,
    required this.buildWidget,
    this.error,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        log("Conn: ${snapshot.connectionState}");
        if (future == null) {
          return (snapshot.connectionState == ConnectionState.none)
              ? noData ?? const SizedBox()
              : shimmer ?? const SizedBox();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return shimmer ?? const SizedBox();
        }

        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return buildWidget(snapshot.data);
          } else {
            return noData ?? const SizedBox();
          }
        }

        log("error: ${snapshot.error.toString()}");

        return snapshot.connectionState == ConnectionState.waiting
            ? shimmer ?? const SizedBox()
            : errorWidget == null
                ? Center(child: Text("error: ${snapshot.error.toString()}"))
                : (errorWidget!(snapshot, snapshot.error.toString()));
      },
    );
  }
}


