import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coindart/constants/app_constants.dart';
import 'package:coindart/components/loginsignupbutton.dart';

class Register extends StatefulWidget {

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register> {

  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white12,

      appBar: AppBar(
        title: const Text( "Register"),
        leading: IconButton(
          icon: const Icon( Icons.arrow_back_ios_new, color: Colors.green, size: 30, ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: isLoading ? const Center( child: CircularProgressIndicator() ) : Form(
        key: formKey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric( horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Hero(
                        tag: "1",
                        child: Text(
                          "Register a new account",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      const SizedBox( height: 30 ),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: ( value ) {
                          email = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty) ? "Please enter an email." : null,
                        textAlign: TextAlign.center,
                        decoration: AppConstants.kTextFieldDecoration.copyWith(
                          hintText: "Enter your email.",
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox( height: 30 ),

                      TextFormField(
                        obscureText: true,
                        validator: ( value ) {
                          if( value!.isEmpty ) {
                            return "Please enter a Password.";
                          }
                        },
                        onChanged: ( value ) {
                          password = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: AppConstants.kTextFieldDecoration.copyWith(
                            hintText: "Choose a password.",
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                        ),
                      ),

                      const SizedBox( height: 80 ),

                      LoginSignupButton(
                        title: "Register",
                        ontapp: () async {
                          if( formKey.currentState!.validate() ) {
                            setState( () {
                              isLoading = true;
                            });

                            try {
                              await _auth.createUserWithEmailAndPassword(email: email, password: password);

                            ScaffoldMessenger.of(context).showSnackBar(

                              const SnackBar(
                                backgroundColor: Colors.blueGrey,
                                content: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "Successfully registered. You can now login."
                                  ),
                                ),

                                duration: Duration(seconds: 5),
                              ),
                            );

                          } on FirebaseAuthException catch( e ) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title:
                                const Text( "Oops! Registration failed."),
                                content: Text( "${e.message}"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      },
                                    child: const Text( "Okay" ),
                                  )
                                ],
                              ),
                            );
                            }
                            setState( () {
                              isLoading = false;
                            });
                          }
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}