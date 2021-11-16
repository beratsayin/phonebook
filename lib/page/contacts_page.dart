import 'package:flutter/material.dart';
import 'package:project1/contactdatabase.dart';
import 'package:project1/contactclass.dart';
import 'edit_contact_page.dart';
import 'contact_detail_page.dart';
import 'package:project1/mywidget/contact_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:project1/mywidget/slidable_widget.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late List<Contact> contacts;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshContacts();
  }

  @override
  void dispose() {
    ContactDatabase.instance.close();

    super.dispose();
  }

  Future refreshContacts() async {
    setState(() => isLoading = true);

    this.contacts = await ContactDatabase.instance.readAllContacts();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Kişiler',
        style: TextStyle(fontSize: 24),
      ),
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : contacts.isEmpty
          ? Text(
        'Ekli Kiþi Yok',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildContacts(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddEditContactPage()),
        );

        refreshContacts();
      },
    ),
  );

  Widget buildContacts() => ListView.separated(
    padding: EdgeInsets.all(8),
    itemCount: contacts.length,
    itemBuilder: (context, index) {
      final contact = contacts[index];

      return GestureDetector(
        onTap: () async {
          //_callNumber();
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactDetailPage(contactId: contact.id!),
          ));

          refreshContacts();
        },
        child: SlidableWidget(
          child: ContactCardWidget(contact: contact, index: index),
          onDismissed:  (action) =>
              dismissSlidableItem(context, index, action),
        ),
      );
    },
    separatorBuilder: (context, index) {
      return Divider(
        color: Colors.white70,
      );
    },
  );

  void dismissSlidableItem(BuildContext context, int index, SlidableAction action) {
    switch (action) {
      case SlidableAction.call:
        _callNumber(contacts.elementAt(index).no);
        break;
      case SlidableAction.message:
        _launchWhatsapp(contacts.elementAt(index).no);
        break;
    }
  }

  _callNumber(String number) async{
    //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  _launchWhatsapp(String number) async{
    String num2 = number;
    String num3 = '0';
    if(num2.startsWith('0')) {
      num3 = num2.replaceRange(0, 0, '+90');
      print('num3');
    }
    if(num2.startsWith('5')) {
      num3 = num2.replaceRange(0, 0, '+90');
      print('num3');
    }
    final link = WhatsAppUnilink(
      phoneNumber: num3,
    );
    await launch('$link');
  }
}