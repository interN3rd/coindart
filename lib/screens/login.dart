import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coindart/components/loginsignupbutton.dart';
import 'package:coindart/constants/app_constants.dart';
import 'package:coindart/screens/register.dart';
import 'coinlist.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {

  _signOut() async {

    await _firebaseAuth.signOut();

  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {

    User? firebaseUser = FirebaseAuth.instance.currentUser;

    return Scaffold(

      backgroundColor: Colors.white12,

      appBar: AppBar(
        title: const Text( "Login" ),
      ),

      body: isloading ? const Center( child: CircularProgressIndicator() ) : Form(
        key: formkey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
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
                      const SizedBox(height: 80),
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
                      const SizedBox(height: 30),
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/" );
              },
            ),
            const Divider(),
            ListTile(
              title: ( firebaseUser == null ? const Text('Register') : const Text('Logout') ),
              tileColor: Colors.deepPurpleAccent,
              onTap: () async {
                firebaseUser == null ? Navigator.pushNamed( context, "/register" ) : await _signOut();
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Contact'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/contact" );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Imprint'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/imprint" );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Status'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/status" );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('close menu'),
              tileColor: Colors.deepPurple,
              onTap: () {
                Navigator.pop( context );
              },
            ),
          ],
        ),
      ),
    );
  }
}