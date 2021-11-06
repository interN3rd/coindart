import 'package:flutter/material.dart';

class AppConstants {

  static const appTitle = "CoinDart - Your Next Bull's Eye Trade";
  // used in AppBar

  static const welcomeMessage = "Welcome to CoinDart! We provide you every extra bit of information that helps you hitting Bull's Eye with your next trade.";
  // used on our front page

  static const loginPrompt = "Please login to your account or register a new one to access the latest crypto charts and your portfolio.";
  // used on our front page

  static const registerPrompt = "By registering a new account you agree to our terms of service.";

  static const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
  );

}