import 'package:flutter/material.dart';
import 'package:project1/contactclass.dart';

class ContactCardWidget extends StatelessWidget {
  ContactCardWidget({
    Key? key,
    required this.contact,
    required this.index,
  }) : super(key: key);

  final Contact contact;
  final int index;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(
        contact.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contact.no.toString(),
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}