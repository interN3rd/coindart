import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindart/components/drawer_menu.dart';
import "package:flutter/material.dart";

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Contact extends StatefulWidget {

  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class FormSubject {

  String label;
  bool isSelected;
  FormSubject( this.label, this.isSelected );

}

class _ContactState extends State<Contact> {

  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';
  List<String> subject = [];
  bool isSelected = false;
  final List<FormSubject> _chipsList = [
    FormSubject("Technical Support", false),
    FormSubject("Legal Inquiry", false),
    FormSubject("Refund Request", false),
    FormSubject("Security issue", false),
  ];

  @override
  Widget build( BuildContext context ) {

    CollectionReference contact = FirebaseFirestore.instance.collection('contact');

    Future<void> submitForm() {

      return contact
          .add({
        'name': name,
        'email': email,
        'message': message
      });
    }

    return Scaffold(

      appBar: AppBar(

          title: const Text( "CoinDart - Contact")
      ),

      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onChanged: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if( value!.isEmpty) {
                      return "Please provide us your name";
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Please enter your name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if( value!.isEmpty) {
                      return "Please provide us your e-mail";
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Your e-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  direction: Axis.horizontal,
                  children: formChips(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: 5,
                  maxLength: 1000,
                  autocorrect: false,
                  onChanged: (value) {
                    message = value;
                  },
                  validator: (value) {
                    if( value!.isEmpty) {
                      return "Please enter a message";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Your message to us',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () {
                        formKey.currentState!.reset();
                        },
                      child: const Text('Delete input'),
                    ),
                    const SizedBox(width: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: submitForm,
                      child: const Text('Submit'),
                    ),
                  ],
            ),
            ],
          ),
        ),
      ),
      ),
      drawer: const DrawerMenu(),
    );
  }

  List<Widget> formChips() {
    List<Widget> chips = [];
    for( int i = 0; i < _chipsList.length; i++ ) {
      Widget item = Padding(
        padding: const EdgeInsets.only( left: 10, right: 5),
        child: FilterChip(
          label: Text( _chipsList[i].label),
          selected: _chipsList[i].isSelected,
          selectedColor: Colors.greenAccent,
          backgroundColor: Colors.deepPurple,
          elevation: 15,
          onSelected: ( bool value ) {
            setState(() {
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add( item );
    }
    return chips;
  }
}