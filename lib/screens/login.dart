import "package:flutter/material.dart";

class Login extends StatelessWidget {

  const Login( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Login"),
      ),

      body: const Center(
        child: LoginForm(),
      ) ,
    );
  }
}

/// form reference: https://flutter.dev/docs/cookbook/forms/validation
class LoginForm extends StatefulWidget {

  const LoginForm( {Key? key} ) : super( key: key );

  @override
  _LoginState createState() {
    return _LoginState();
  }

}

class _LoginState extends State<LoginForm> {

  static const username = "mob";
  static const password = "bom";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build( BuildContext context ) {
    return Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                ),
                validator: (value) {
                  if( value == null || value.isEmpty) {
                    return "Please enter your username.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                ),
                validator: (value) {
                  if( value == null || value.isEmpty) {
                    return "Please enter your password.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  if( _formKey.currentState!.validate() ) {
                    ScaffoldMessenger.of( context ).showSnackBar(
                      const SnackBar( content: Text( "Your input is being processed") ),
                    );
                  }

                  if( username == "mob" && password == "bom" ) {

                    Navigator.pushNamed( context, "/coinlist" );
                    ScaffoldMessenger.of( context ).showSnackBar(
                      const SnackBar( content: Text( "You are now logged in.") ),
                    );
                  }
                },
                child: const Text("Login"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),),
              ),
            ],
          ),
        )
    );
  }
}