import 'package:coindart/components/drawer_menu.dart';
import 'package:coindart/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> healthCheck() async {
  // healthCheck to provide unauthenticated user information about
  // operational status of coinmarketcap api
  // API-URL and API-Key
  const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=1';
  final Map<String, String> tokenData = {
    "X-CMC_PRO_API_KEY": "8836be1d-8855-43d4-8689-3e9f9f0911c7",
  };

  // API-Call
  final response = await http.get(Uri.parse(url), headers: tokenData);

  if( response.statusCode == 200 ) {
    return true;
  } else {
    return false;
  }

}

class Status extends StatefulWidget {

  const Status({Key? key}) : super(key: key);

  @override
  _StatusState createState() => _StatusState();

}

class _StatusState extends State<Status> {

  Future<bool>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = healthCheck();
  }

  @override
  Widget build(BuildContext context) {

    User? firebaseUser = FirebaseAuth.instance.currentUser;
    var email;

    String authStatus;
    if( firebaseUser != null ) {
      email = firebaseUser.email;
      authStatus = "You signed in with your email " + email + " and you are an authenticated user.";
    } else {
      authStatus = AppConstants.loggedOut;
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text( "Status" )
      ),

      body: Container(

        padding: const EdgeInsets.all( 30 ),

        child: Column(

            children:  <Widget> [

            const Text(
                "Here you will find technical information regarding the status of the app, e.g. if you are an authenticated user or the API is functional.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                )
            ),
              const Divider(),
              const Text(
                  "Your login status",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17
                  )
              ),
              Text(
                  authStatus,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: ( firebaseUser == null ? Colors.redAccent : Colors.greenAccent ),
                      fontSize: 17
                  )
              ),
              const Divider(),
              const Text(
                  "Operational status of coinmarketcap API",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17
                  )
              ),
              FutureBuilder<bool>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data == true ? "operational" : "not operational",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: snapshot.data == true ? Colors.greenAccent : Colors.redAccent,
                          fontSize: 17
                      )
                    );
                  } else if(snapshot.hasError) {
                    return const Text("Unable to confirm API status");
                  }
                  return const Center(child: CircularProgressIndicator());
                })

            ],
        ),
      ),
      drawer: DrawerMenu(),
    );
  }
}