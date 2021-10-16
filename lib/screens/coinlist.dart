import "package:flutter/material.dart";

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