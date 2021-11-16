import 'package:flutter/material.dart';
import 'package:project1/contactdatabase.dart';
import 'package:project1/contactclass.dart';
import 'edit_contact_page.dart';

class ContactDetailPage extends StatefulWidget {
  final int contactId;

  const ContactDetailPage({
    Key? key,
    required this.contactId,
  }) : super(key: key);

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  late Contact contact;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshContact();
  }

  Future refreshContact() async {
    setState(() => isLoading = true);

    this.contact = await ContactDatabase.instance.readContact(widget.contactId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView(
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
          padding: EdgeInsets.fromLTRB(15, 15, 15, 30),
          child: Text('${contact.name}',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          padding: EdgeInsets.fromLTRB(15, 15, 15, 30),
          child: Text('${contact.no}',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
  );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditContactPage(contact: contact),
        ));

        refreshContact();
      });

  Widget deleteButton() => IconButton(
    icon: Icon(Icons.delete),
    onPressed: () async {
      showAlertDialog(context);
    },
  );

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Ýptal"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Kiþiyi sil"),
      onPressed:  () async {
        await ContactDatabase.instance.delete(widget.contactId);

        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("1 Kiþi Silinecek"),
      content: Text("${contact.name} kiþisi silinsin mi?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}