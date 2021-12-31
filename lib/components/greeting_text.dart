import 'package:coindart/constants/app_constants.dart';
import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {

  const GreetingText({Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {

    return Column(
      children: const <Widget> [
        Text(
          AppConstants.welcomeMessage,
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17
          ),
        ),
      Divider(),
      Text(
          AppConstants.loginPrompt,
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