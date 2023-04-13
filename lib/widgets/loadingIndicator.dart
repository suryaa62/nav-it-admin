import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator(
      {super.key, required this.child, required this.isBusy});
  final Widget child;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isBusy,
      child: Stack(
        children: [
          child,
          if (isBusy)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const LinearProgressIndicator(),
                Expanded(
                    child: Container(
                        width: double.infinity, color: Colors.black38)),
              ],
            )
        ],
      ),
    );
  }
}
