//contacts is the name of the table that created in contactdatabase
final String tableContacts = 'contacts';

//defines column names in create table
class ContactFields {
  static final List<String> values = [
    id, name, no
  ];

  static final String id = '_id';
  static final String name = '_name';
  static final String no = '_no';
}

//defines fields of contact and initializes
class Contact {
  final int? id;
  final String name;
  final String no;

  const Contact({
    this.id,
    required this.name,
    required this.no,
  });

  //copies the current contact object. needed for create method in contactdatabase
  Contact copy({
    int? id,
    String? name,
    String? no,
  }) =>
      Contact(
        id: id ?? this.id,
        name: name ?? this.name,
        no: no ?? this.no,
      );

  //converts json object to contact object
  static Contact fromJson(Map<String, Object?> json) => Contact(
    id: json[ContactFields.id] as int?,
    name: json[ContactFields.name] as String,
    no: json[ContactFields.no] as String,
  );

  //converts contact object to json to be able to add it to the database
  Map<String, Object?> toJson() => {
    ContactFields.id: id,
    ContactFields.name: name,
    ContactFields.no: no,
  };
}