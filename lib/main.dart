// ignore_for_file: prefer_const_constructors, missing_required_param

import 'package:firebase_core/firebase_core.dart';
import 'package:sucursales_app/providers/sucursal_provider.dart';
import 'package:sucursales_app/screens/sucursals.dart';
import 'package:sucursales_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SucursalProvider()),
        StreamProvider(create: (context) => firestoreService.getSucursal()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Sucursals(),
      ),
    );
  }
}
