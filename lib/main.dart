import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";

void main() => runApp(const Coindart());

/// to prevent typos. Please use "Routes.<name of route>" to link different
/// widgets/screens. And, of course, add any new route to this class before
/// its use in any widget
class Routes {

  static const coindart = "/";
  static const login = "/login";
  static const register = "/register";
  static const contact = "/contact";
  static const imprint = "/imprint";
  static const coinlist = "/coinlist";

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

        title: "Coindart",
        /// routing reference: https://flutter.dev/docs/cookbook/navigation/named-routes
        routes: {
          "/contact": ( context ) => Contact(),
          "/imprint": ( context ) => const Imprint(),
          "/login": ( context ) => const Login(),
          "/register": ( context ) => const Register(),
          "/coinlist": ( context ) => Coinlist(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white12,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              centerTitle: true
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle( color: Colors.white ),
            subtitle1: TextStyle( color: Colors.white ),
          ),
        ),

      home: Builder(
        builder: (context) => Scaffold(

        appBar: AppBar(

          title: const Text( appTitle )

        ),

        body: Container(

          padding: const EdgeInsets.all( 30 ),

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
                      onPressed:  () {
                        Navigator.pushNamed( context, "/login" );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      )
                    ),

                    const SizedBox( width: 50),

                    ElevatedButton(
                      child: const Text( "Register" ),
                      onPressed:  () {
                        Navigator.pushNamed( context, "/register" );
                      },
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
                          Navigator.pushNamed( context, Routes.contact );
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

  /// the _formKey allows to view, modify and process form data and its state
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build( BuildContext context ) {

    return Scaffold(

      appBar: AppBar(

        title: const Text( "CoinDart - Contact")
      ),

      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [

            /// the value of name is used to reference this textfield
            FormBuilderTextField( name: "name" ),

            Row(
              children: [
                ElevatedButton(

                    onPressed: () {
                      /// tapping the button "Reset form" does two things:
                      _formKey.currentState!.reset();
                      /// deletes all input
                      FocusScope.of( context ).unfocus();
                      /// makes the user's keyboard disappear
                    },
                    child: const Text( "Reset form")

                ),

                const SizedBox( width: 50),

                ElevatedButton(

                    onPressed: () {},
                    child: const Text( "Submit")

                ),
              ],
            ),
          ],
        ),

        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class Imprint extends StatelessWidget {

  const Imprint( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    return Scaffold(

        appBar: AppBar(

            title: const Text( "Imprint"),
        ),

      body: Container(

        padding: const EdgeInsets.all( 30 ),

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
    );
  }
}

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

                    Navigator.pushNamed( context, Routes.coinlist );
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

class Register extends StatefulWidget {

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Coinlist extends StatelessWidget {

  final List<String> coins = <String>[
      "Bitcoin",
      "Etherum",
      "Binance Coin",
      "Cardano",
      "Tether",
      "XRP",
      "Solana",
      "Polkadot",
      "USD Coin",
      "Dogecoin",
      "Uniswap",
      "Terra",
      "Wrapped Bitcoin",
      "Litecoin",
      "Binance USD",
      "Chainlink",
      "Avalanche",
      "Bitcoin Cash",
      "Algorand",
      "Polygon",
      "SHUBA INU",
      "Stellar",
      "Internet Computer",
      "VeChain",
      "Axie Infinity" ];

  @override
  Widget build( BuildContext context ) {

    return Scaffold(


      appBar: AppBar(

        title: const Text( "Available Coins"),
      ),

      body: Container(

        padding: const EdgeInsets.all( 30 ),

        child: ListView.builder(
            itemCount: coins.length,
            itemBuilder: ( context, index ) {
              return ListTile(
                title: Text( coins[index] ),
              );
            },
          ),
        ),
      );
  }
}
