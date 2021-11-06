// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucursales_app/models/sucursal.dart';
import 'package:sucursales_app/screens/edit_sucursal.dart';

class Sucursals extends StatelessWidget {
  const Sucursals({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sucursals = Provider.of<List<Sucursal>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Sucursales'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditSucursal()));
                },
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                )),
          ],
        ),
        body: (sucursals != null)
            ? ListView.builder(
                itemCount: sucursals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(sucursals[index].name),
                    trailing: Text(sucursals[index].phone.toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditSucursal(sucursals[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
