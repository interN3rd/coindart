import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindart/components/price_chart.dart';
import 'dart:async';
import 'dart:convert';
import 'package:coindart/components/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;
String noData = "[No Data available]";

Future<Coin> fetchCoinData(final String coinId) async {

  // API-URL and API-Key
  String urlInfo = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/info?id=' + coinId;
  String urlQuotes = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?id=' + coinId;

  final Map<String, String> tokenData = {
    "X-CMC_PRO_API_KEY": "8836be1d-8855-43d4-8689-3e9f9f0911c7",
  };

  // API-Call
  final responseInfo = await http.get(Uri.parse(urlInfo), headers: tokenData);
  final responseQuotes = await http.get(Uri.parse(urlQuotes), headers: tokenData);

  if (responseInfo.statusCode == 200 && responseQuotes.statusCode == 200) {

    final dynamic jsonInfo = jsonDecode(responseInfo.body)['data'][coinId];
    final dynamic jsonQuotes = jsonDecode(responseQuotes.body)['data'][coinId];

    return Coin(
        id: jsonInfo['id'],
        name: (jsonInfo['name'] == null) ? noData : jsonInfo['name'],
        symbol: (jsonInfo['symbol'] == null) ? noData : jsonInfo['symbol'],
        logo: (jsonInfo['logo'] == null) ? noData : jsonInfo['logo'],
        website: (jsonInfo['urls']['website'][0] == null) ? noData : jsonInfo['urls']['website'][0],
        price: (jsonQuotes['quote']['USD']['price'] == null) ? noData : jsonQuotes['quote']['USD']['price'].toString(),
        circSupply: (jsonQuotes['circulating_supply'] == null) ? noData : jsonQuotes['circulating_supply'].toString(),
        maxSupply: (jsonQuotes['max_supply'] == null) ? noData : jsonQuotes['max_supply'].toString(),
        marketCap: (jsonQuotes['quote']['USD']['market_cap'] == null) ? noData : jsonQuotes['quote']['USD']['market_cap'].toString(),
        changeDay: (jsonQuotes['quote']['USD']['percent_change_24h'] == null) ? noData : jsonQuotes['quote']['USD']['percent_change_24h'].toString(),
        changeWeek: (jsonQuotes['quote']['USD']['percent_change_7d'] == null) ? noData : jsonQuotes['quote']['USD']['percent_change_7d'].toString()
    );

  } else {
    // If the server did not return a 200 OK response then throw an exception.
    throw Exception('Failed to load Coin Data');
  }
}

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

Future<bool> buyCoin(double newCredit, String coinName) async {

  var collection = FirebaseFirestore.instance.collection("user/" + user!.uid + "/coins");
  var docSnapshot = await collection.doc(coinName).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    num currentAmount = data?['amount'];
    collection.doc(coinName).set({
      "amount": currentAmount + 1,
    });
  } else {
    collection.doc(coinName).set({
      "amount": 1,
    });
  }

  collection = FirebaseFirestore.instance.collection('user');
  collection.doc(user!.uid).set({
    "credit": newCredit,
  });

  return true;
}

Future<bool> sellCoin(double newCredit, String coinName) async {

  var collection = FirebaseFirestore.instance.collection("user/" + user!.uid + "/coins");
  var docSnapshot = await collection.doc(coinName).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    num currentAmount = data?['amount'];
    num newAmount = currentAmount - 1;
    collection.doc(coinName).set({
      "amount": newAmount,
    });
    if(newAmount < 1) {
      await FirebaseFirestore.instance.runTransaction((Transaction delTrans) async {
        delTrans.delete(collection.doc(coinName));
      });
      if(newAmount < 0) {
        return false;
      }
    }
  } else {
    return false;
  }

  collection = FirebaseFirestore.instance.collection('user');
  collection.doc(user!.uid).set({
    "credit": newCredit,
  });

  return true;
}

class Coin {
  num id;
  String name;
  String symbol;
  String logo;
  String website;
  String price;
  String circSupply;
  String maxSupply;
  String marketCap;
  String changeDay;
  String changeWeek;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
    required this.website,
    required this.price,
    required this.circSupply,
    required this.maxSupply,
    required this.marketCap,
    required this.changeDay,
    required this.changeWeek
  });

}

class Details extends StatefulWidget {
  const Details({Key? key, required this.coinId, required this.coinName}) : super(key: key);
  final String coinId;
  final String coinName;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future<Coin>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchCoinData(widget.coinId);
  }

  @override
  Widget build(BuildContext context) {

    String currentPriceAsString = '';
    double currentPriceAsDouble = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<Coin>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String symbol = snapshot.data!.symbol;
              currentPriceAsString = snapshot.data!.price;
              currentPriceAsDouble = num.tryParse( currentPriceAsString )!.toDouble();
              return Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    PriceChart( symbol, currentPriceAsDouble ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          height: 34,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () async {
                              double userCredit = await fetchUserCredit();
                              double coinPrice = double.parse(snapshot.data!.price);
                              if(userCredit < coinPrice) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Insufficient Credit!"), backgroundColor: Colors.redAccent)
                                );
                              } else {
                                double newCredit = (userCredit - coinPrice);
                                bool coinBought = await buyCoin(newCredit, snapshot.data!.name);
                                if(coinBought) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("You successfully purchased 1 " + snapshot.data!.name + "!"), backgroundColor: Colors.green)
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Coin purchase failed! Please try again later."), backgroundColor: Colors.redAccent)
                                  );
                                }
                              }
                            },
                            child: Text("BUY " + snapshot.data!.symbol,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 100,
                          height: 34,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                            ),
                            onPressed: () async {
                              double userCredit = await fetchUserCredit();
                              double coinPrice = double.parse(snapshot.data!.price);
                              double newCredit = (userCredit + coinPrice);
                              bool coinSold = await sellCoin(newCredit, snapshot.data!.name);
                              if(coinSold) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("You successfully sold 1 " + snapshot.data!.name + "!"), backgroundColor: Colors.green,)
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("You currently don't possess any " + snapshot.data!.name + " to sell."), backgroundColor: Colors.redAccent)
                                );
                              }
                            },
                            child: Text("SELL " + snapshot.data!.symbol,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    const Hero(
                      tag: '1',
                      child: Text(
                        "Overview",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent
                        ),
                      ),
                    ),
                    Text(
                      widget.coinName + " is a cryptocurrency. Its symbol is " + snapshot.data!.symbol + ".",
                      textAlign: TextAlign.justify,
                    ),
                    const Divider( height: 30 ),
                    const Hero(
                      tag: '2',
                      child: Text(
                        'Supply',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent
                        ),
                      ),
                    ),
                    Text(
                      "There is a total supply of " + snapshot.data!.maxSupply + " " + snapshot.data!.symbol + ". Out of this total supply there is a circulating supply of " + snapshot.data!.circSupply + " " + snapshot.data!.symbol + ".",
                      textAlign: TextAlign.justify,
                    ),
                    const Divider( height: 30),
                    const Hero(
                      tag: '3',
                      child: Text(
                        'Price Change',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent
                        ),
                      ),
                    ),
                    Text(
                      "Currently one " + snapshot.data!.symbol + " trades for \$" + snapshot.data!.price + ". Compared to the day before the price change is " + snapshot.data!.changeDay + ". And compared to last week the price change is " + snapshot.data!.changeWeek + ".",
                      textAlign: TextAlign.justify,
                    ),
                    const Divider( height: 30),
                    const Hero(
                      tag: '4',
                      child: Text(
                        'Market Cap',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent
                        ),
                      ),
                    ),
                    Text(
                      "The total market capitalization (market cap) of " + snapshot.data!.symbol + " at the moment is \$" + snapshot.data!.marketCap,
                      textAlign: TextAlign.justify,
                    ),
                    const Divider( height: 30),
                    const Hero(
                      tag: '5',
                      child: Text(
                        'Website',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent
                        ),
                      ),
                    ),
                    Text(
                      "To get more information about " + snapshot.data!.name + " please visit " + snapshot.data!.website + ". The website usually contains access to a software wallet and the whitepaper of a cryptocurrency.",
                      textAlign: TextAlign.justify,
                    ),
                  ]
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
      drawer: const DrawerMenu(),
    );
  }
}