import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Coindart",
      /// routing reference: https://flutter.dev/docs/cookbook/navigation/named-routes
      initialRoute: "/",
      routes: {
        "/": ( context ) => const Coindart(),
        "/contact": ( context ) => const Contact(),
        "/imprint": ( context ) => const Imprint(),
      },
    ),
  );
}

class Coindart extends StatelessWidget {

  const Coindart( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    const appTitle = "CoinDart - Your Next Bull's Eye Trade";
    // used in AppBar

    const welcomeMessage = "Welcome to CoinDart! We provide you every extra bit of information that helps you hitting Bull's Eye with your next trade.";
    // used on our front page

    const loginPrompt = "Please login to your account or register a new one to access the latest crypto charts and your portfolio.";
    // used on our front page

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

                children:  <Widget> [

                  const Text(
                      welcomeMessage,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                  ) ),
                  const Divider(),
                  const Text(
                    loginPrompt,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                    ) ),
                  const Divider(),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget> [

                      ElevatedButton(

                        child: const Text( "Login" ),
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        )
                      ),

                      const SizedBox( width: 50),

                      ElevatedButton(
                        child: const Text( "Register" ),
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>( Colors.deepPurple ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        )
                      )

                    ]
                  ),

                  const Spacer(),
                  Row(

                      mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget> [

                        TextButton(

                          onPressed: () {
                            Navigator.pushNamed( context, "/contact" );
                          },
                          child: const Text(
                              "Contact",
                              style: TextStyle(

                                  color: Colors.deepPurple
                          ))
                      ),

                        const SizedBox( width: 50),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed( context, "/imprint" );
                        },
                        child: const Text(
                            "Imprint",
                            style: TextStyle(
                                color: Colors.deepPurple
                        ))
                      )
                    ]
                  )
                ]
      ) ) ) ) );
  }
}

class Contact extends StatelessWidget {

  const Contact( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    return Scaffold(

      appBar: AppBar(

        title: const Text( "CoinDart - Contact")
      ),

      body: Center(
        child: ElevatedButton(

    onPressed: () {

      Navigator.pop( context );

      },

    child: const Text( "Go back!"),
      )
    ));
  }
}

class Imprint extends StatelessWidget {

  const Imprint( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    return Scaffold(

      backgroundColor: Colors.white12,

        appBar: AppBar(

            backgroundColor: Colors.deepPurple,
            title: const Text( "Imprint"),
        ),

      body: Container(

        padding: const EdgeInsets.all( 30 ),

        child: Expanded(

          child: Column(

            children: const <Widget> [

              Text(
                "This software project was carefully crafted by Fachhochschule Kiel students Alexander Neumann and Pascal Groß. For legal inquiries please send a letter to",
              textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),
              ),

              Divider(),

              Text("CoinDart AG GmbH MfG" "\n"
                    "CoinDart Ave No. 1" "\n"
                    "12345 CoinDartropolis" "\n"
                    "United Darts of Coins" "\n"
                    "\n"
                    "Our legal team will surely and truthfully shred all received documents.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
