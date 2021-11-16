import 'package:flutter/material.dart';
import 'package:project1/contactdatabase.dart';
import 'package:project1/contactclass.dart';
import 'package:project1/mywidget/contact_form_widget.dart';

class AddEditContactPage extends StatefulWidget {
  final Contact? contact;

  const AddEditContactPage({
    Key? key,
    this.contact,
  }) : super(key: key);
  @override
  _AddEditContactPageState createState() => _AddEditContactPageState();
}

class _AddEditContactPageState extends State<AddEditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String no;

  @override
  void initState() {
    super.initState();

    name = widget.contact?.name ?? '';
    no = widget.contact?.no ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: ContactFormWidget(
        name: name,
        no: no,
        onChangedName: (name) => setState(() => this.name = name),
        onChangedNo: (no) => setState(() => this.no = no),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty && no.toString().isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateContact,
        child: Text('Kaydet'),
      ),
    );
  }

  void addOrUpdateContact() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.contact != null;

      if (isUpdating) {
        await updateContact();
      } else {
        await addContact();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateContact() async {
    final contact = widget.contact!.copy(
      name: name,
      no: no,
    );

    await ContactDatabase.instance.update(contact);
  }

  Future addContact() async {
    final contact = Contact(
      name: name,
      no: no,
    );
    print(await ContactDatabase.instance.readAllContacts());
    await ContactDatabase.instance.create(contact);
  }
}