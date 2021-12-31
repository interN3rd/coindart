import 'package:flutter/material.dart';

class InvisibleWidget extends StatelessWidget {

  // usage: some content should only be accessible by authenticated users. Use
  // this invisible widget to display to non-authenticated users while
  // authenticated users are shown options, that are restricted
  const InvisibleWidget({Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {

    return const Visibility(
      child: Text("invisible"),
      visible: false,
    );
  }
}