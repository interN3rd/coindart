import 'dart:async';
import 'dart:convert';
import 'package:coindart/components/menu/drawer_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'details.dart';

User? user = FirebaseAuth.instance.currentUser;
CollectionReference favorites = FirebaseFirestore.instance.collection("user/" + user!.uid + "/favorites");

Future<List<Coin>> fetchCoin() async {

  // API-URL and API-Key
  const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=20';
  final Map<String, String> tokenData = {
    "X-CMC_PRO_API_KEY": "8836be1d-8855-43d4-8689-3e9f9f0911c7",
  };

  // API-Call
  final response = await http.get(Uri.parse(url), headers: tokenData);

  // Get Favorites from Database
  List<num> favIds = [];
  await favorites.get().then((snapshot) {
    for (var doc in snapshot.docs) {
      favIds.add(int.parse(doc.id));
    }
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response then parse the JSON.
    List<Coin> result = [];
    for( var i = 0 ; i < 20; i++ ) {
      result.add(Coin.fromJson(jsonDecode(response.body)['data'][i]));
      if(favIds.contains(result[i].id)) {
        result[i].changeFavorite();
      }
    }
    return result;
  } else {
    // If the server did not return a 200 OK response then throw an exception.
    throw Exception('Failed to load Coins');
  }
}

class Coin {
  final num id;
  final String name;
  final num price;
  final num change;
  bool isFavorite = false;

  Coin({
    required this.id,
    required this.name,
    required this.price,
    required this.change
  });

  factory Coin.fromJson(dynamic json) {
    return Coin(
      id: json['id'],
      name: json['name'],
      price: json['quote']['USD']['price'],
      change: json['quote']['USD']['percent_change_24h']
    );
  }

  void changeFavorite() {
    isFavorite = !isFavorite;
  }
}

class Coinlist extends StatefulWidget {
  const Coinlist({Key? key}) : super(key: key);

  @override
  _CoinlistState createState() => _CoinlistState();
}

class _CoinlistState extends State<Coinlist> {
  Future<List<Coin>>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchCoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Coins'),
      ),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(width: 35),
                  Expanded(child: Text( "Name" )),
                  Text( "Price" ),
                  SizedBox(child: Text( "24h", textAlign: TextAlign.right ), width: 80),
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: FutureBuilder<List<Coin>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ( context, index ) {
                        // document ID for Firestore will be the same as the coin ID from the API
                        final docId = snapshot.data!.elementAt(index).id.toString();
                        return ListTile(
                            title:
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 35, child:
                                  // --- Button to mark coins as favorites (saved in Firestore) --- //
                                  IconButton(onPressed: () async {
                                    final getFav = await favorites.doc(docId).get();
                                    // Add a coin to favorites or remove if already set as favorite
                                    if(!getFav.exists) {
                                      favorites.doc(docId).set({
                                        "id": snapshot.data!.elementAt(index).id,
                                        "name": snapshot.data!.elementAt(index).name,
                                      });
                                      setState(() {
                                        snapshot.data!.elementAt(index).changeFavorite();
                                      });
                                    } else {
                                      FirebaseFirestore.instance.runTransaction((Transaction delTrans) async {
                                        delTrans.delete(favorites.doc(docId));
                                        setState(() {
                                          snapshot.data!.elementAt(index).changeFavorite();
                                        });
                                      });
                                    }
                                  }, 
                                    icon: Icon((snapshot.data!.elementAt(index).isFavorite) ? CupertinoIcons.heart_fill : CupertinoIcons.heart, color: Colors.deepPurple),
                                    padding: const EdgeInsets.only(right: 20)
                                  )
                                ),
                                // Name, price and 24h price change
                                Expanded(
                                  child: GestureDetector(
                                    child: Text( snapshot.data!.elementAt(index).name ),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Details(
                                            coinId: snapshot.data!.elementAt(index).id.toString(),
                                            coinName: snapshot.data!.elementAt(index).name,
                                          )
                                        ),
                                      );
                                    }
                                  )
                                ),
                                Text( "\$" + snapshot.data!.elementAt(index).price.toStringAsFixed(4) ),
                                SizedBox(child: Text( snapshot.data!.elementAt(index).change.toStringAsFixed(2) + "%", textAlign: TextAlign.right, ), width: 80),
                              ],
                            )
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    print("Snapshot.hasError");
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const DrawerMenu(),
    );
  }
}