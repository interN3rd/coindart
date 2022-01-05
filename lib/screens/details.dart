import 'dart:async';
import 'dart:convert';
import 'package:coindart/components/drawer_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;
String noData = "[Data currently unavailable]";

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinName),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<Coin>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Flex(
                direction: Axis.vertical,
                children: [
                  Text(snapshot.data!.symbol),
                  Text(snapshot.data!.price),
                  Text(snapshot.data!.circSupply),
                  Text(snapshot.data!.maxSupply),
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