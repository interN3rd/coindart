import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";

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