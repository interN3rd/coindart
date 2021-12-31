import 'package:coindart/constants/app_constants.dart';
import 'package:coindart/screens/coinlist.dart';
import 'package:coindart/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginsignupbutton.dart';

class LoginForm extends StatefulWidget {

  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();

}

class _LoginFormState extends State<LoginForm> {

  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build( BuildContext context ) {

    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter Email";
            }
          },
          textAlign: TextAlign.center,
          decoration: AppConstants.kTextFieldDecoration.copyWith(
            hintText: 'Email',
            prefixIcon: const Icon(
              Icons.email_rounded,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 30),
        TextFormField(
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter Password";
            }
          },
          onChanged: (value) {
            password = value;
          },
          textAlign: TextAlign.center,
          decoration: AppConstants.kTextFieldDecoration.copyWith(
              hintText: 'Password',
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              )),
        ),
        const SizedBox(height: 20),
        LoginSignupButton(
          title: 'Login',
          ontapp: () async {
            if (formkey.currentState!.validate()) {
              setState(() {
                isloading = true;
              });
              try {
                await _auth.signInWithEmailAndPassword(
                    email: email, password: password);

                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => const Coinlist(),
                  ),
                );

                setState(() {
                  isloading = false;
                });
              } on FirebaseAuthException catch (e) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Ops! Login Failed"),
                    content: Text('${e.message}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Okay'),
                      )
                    ],
                  ),
                );
                print(e);
              }
              setState(() {
                isloading = false;
              });
            }
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Register(),
              ),
            );
          },
          child: Row(
            children: const [
              Text(
                "Don't have an account?",
                style: TextStyle(
                    fontSize: 20, color: Colors.deepPurpleAccent),
              ),
              SizedBox(width: 10),
              Hero(
                tag: '1',
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}