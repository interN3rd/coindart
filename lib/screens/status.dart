import 'package:coindart/components/menu/drawer_menu.dart';
import 'package:coindart/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// healthCheck to provide unauthenticated users information about
// operational status of coinmarketcap api
Future<bool> healthCheck() async {

  // API-URL and API-Key
  const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=1';
  final Map<String, String> tokenData = {
    "X-CMC_PRO_API_KEY": "195a8398-cf16-44bd-8e63-cf59d9670dfa",
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
    String? email;

    String authStatus;
    if( firebaseUser != null ) {
      email = firebaseUser.email;
      authStatus = "You signed in with your email " + email! + " and you are an authenticated user.";
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
                // depending on the return value of healthCheck() a notification
                // is displayed that informs the user about the API's
                // operational status
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
      drawer: const DrawerMenu(),
    );
  }
}