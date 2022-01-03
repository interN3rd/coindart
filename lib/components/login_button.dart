import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
        fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 40)),
        shadowColor: MaterialStateProperty.all<Color>(Colors.black12),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )
        )
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/login");
        },
      child: const Text("Login"),
    );
  }
}