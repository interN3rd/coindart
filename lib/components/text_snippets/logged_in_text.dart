import 'package:coindart/constants/app_constants.dart';
import 'package:flutter/material.dart';

class LoggedInText extends StatelessWidget {

  const LoggedInText({Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {

    return Column(
      children: const <Widget> [
        Text(
          AppConstants.loggedInGreeting,
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17
          ),
        ),
      ],
    );
  }
}