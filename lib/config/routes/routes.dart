import 'package:coindart/screens/login.dart';
import 'package:coindart/screens/register.dart';
import 'package:flutter/widgets.dart';
import 'package:coindart/screens/coinlist.dart';
import 'package:coindart/screens/contact.dart';
import 'package:coindart/screens/imprint.dart';

/// routing reference: https://flutter.dev/docs/cookbook/navigation/named-routes
final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {

  "/login": ( BuildContext context ) => const Login(),
  "/register": ( BuildContext context ) => const Register(),
  "/coinlist": ( BuildContext context ) => Coinlist(),
  "/contact": ( BuildContext context ) => Contact(),
  "/imprint": ( BuildContext context ) => const Imprint(),

};