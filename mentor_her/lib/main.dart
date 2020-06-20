import 'package:flutter/material.dart';
import 'package:havemyback/CRUDModel.dart';
import 'package:havemyback/locator.dart';
import 'package:provider/provider.dart';
import 'starting-page/root_page.dart';
import 'starting-page/authentication.dart';
//import 'app_loader.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}


//-----------------------ROOT---------------------------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
      ],
      child: MaterialApp(
          title: 'Have My Back',
          theme: ThemeData(
            primarySwatch: Colors.red,
            brightness: Brightness.light,
            primaryColor: Colors.white,
            accentColor: Colors.redAccent[200],
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: new RootPage(auth: new Auth())),
    );

  }
}












