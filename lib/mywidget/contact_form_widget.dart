import 'package:flutter/material.dart';

class ContactFormWidget extends StatelessWidget {
  final String? name;
  final String? no;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedNo;

  const ContactFormWidget({
    Key? key,
    this.name = '',
    this.no = '',
    required this.onChangedName,
    required this.onChangedNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text('AD:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: buildTitle(),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text('NUMARA:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: buildDescription(),
      ),
    ],
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: name,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Ad giriniz',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'The name cannot be empty' : null,
    onChanged: onChangedName,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 1,
    initialValue: no,
    style: TextStyle(color: Colors.white60, fontSize: 18),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Numara giriniz',
      hintStyle: TextStyle(color: Colors.white60),
    ),
    validator: (no) => no != null && no.isEmpty
        ? 'The no cannot be empty'
        : null,
    onChanged: onChangedNo,
  );
}