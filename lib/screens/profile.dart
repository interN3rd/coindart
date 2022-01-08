import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindart/components/menu/drawer_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;

Future<double> fetchUserCredit() async {

  var collection = FirebaseFirestore.instance.collection('user');
  var docSnapshot = await collection.doc(user!.uid).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    return data?['credit'].toDouble();
  } else {
    return 0;
  }
}

class Profile extends StatefulWidget {

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

  Future<double>? balance;

  @override
  void initState() {
    super.initState();
    balance = fetchUserCredit();
  }

  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      appBar: AppBar(
        title: const Text( "User Profile" )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all( 30 ),
        child: FutureBuilder<double>(
          future: balance,
          builder: (context, snapshot ) {
            if( snapshot.hasData) {
              double balanceAvailable = snapshot.data!;

              return Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Hero(
                    tag: '1',
                    child: Text(
                      "Balance",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent
                      ),
                    ),
                  ),
                  Text(
                    "You have a balance available of: \$" + balanceAvailable.toStringAsFixed(2),
                  ),
                  const Divider( height: 10),
                  ElevatedButton(
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

                    },
                    child: const Text("Deposit money into your account"),
                  ),
                  const Divider( height: 10),
                  ElevatedButton(
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
                      Navigator.pushNamed(context, "/coinlist");
                      },
                    child: const Text("Buy more crypto now"),
                  ),
                  const Divider( height: 30),
                  const Hero(
                    tag: '2',
                    child: Text(
                      "Coins in possession",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent
                      ),
                    ),
                  ),
                ],
              );
            } else if ( snapshot.hasError) {
              return Text( '${snapshot.error}');
            }
            return const Center( child: CircularProgressIndicator(),);
          },
        ),
      ),
      drawer: const DrawerMenu(),
    );
  }
}