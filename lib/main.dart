import 'package:flutter/material.dart';

void main() => runApp( Coindart() );

class Coindart extends StatelessWidget {

  const Coindart( {Key? key} ) : super( key: key);

  @override
  Widget build( BuildContext context ) {

    const appTitle = "Coindart - Your Next Bull's Eye Trade";
    const welcomeMessage = "Welcome to CoinDart! We provide you every extra bit of information that helps you hitting Bull's Eye with your next trade.";
    const loginPrompt = "Please login to your account or register a new one to access the latest crypto charts and your portfolio.";

    return MaterialApp(

      title: appTitle,

      home: Scaffold(

        backgroundColor: Colors.white12,

        appBar: AppBar(

          backgroundColor: Colors.deepPurple,
          title: const Text( appTitle )

        ),

        body: Container(

            padding: const EdgeInsets.all( 30 ),

          child: Expanded(

            child: Column(

                children: const [
                  
                  Text(
                      welcomeMessage,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                  ) ),
                  Divider(),
                  Text(
                    loginPrompt,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                    ) ),
                  Divider(),
                ]
      ) ) ) ) );
  }
}

/// form reference: https://flutter.dev/docs/cookbook/forms/validation
class Login extends StatefulWidget {

  const Login( {Key? key} ) : super( key: key );

  @override
  LoginState createState() {

    return LoginState();
  }

}

class LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build( BuildContext context ) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if( value == null || value.isEmpty) {
                return "Bitte gib einen Text ein.";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if( _formKey.currentState!.validate() ) {
                  ScaffoldMessenger.of( context ).showSnackBar(
                    const SnackBar( content: Text( "Eingabe wird verarbeitet") ),
                  );
                }
              },
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
