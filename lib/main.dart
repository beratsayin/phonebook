import 'package:flutter/material.dart';
import 'page/contacts_page.dart';
import 'package:flutter/services.dart';

void main() async {
  //makes sure that database is initialized
  WidgetsFlutterBinding.ensureInitialized();

  //specifies the set of orientations the application interface can be displayed in
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //runs app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //Title of the app
  static final String title = 'Adres Defteri';

  //this widget builds base of home page
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: title,
    themeMode: ThemeMode.dark,
    theme: ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
    //assigns home page of app to ContactsPage class
    home: ContactsPage(),
  );
}