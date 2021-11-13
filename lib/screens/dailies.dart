import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucursales_app/models/dailies_sales.dart';
import 'package:sucursales_app/screens/edit_dailies.dart';

class Dailies extends StatelessWidget {
  const Dailies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailies = Provider.of<List<DailiesSales>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Ventas diarias'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditDailiesSales()));
                },
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                )),
          ],
        ),
        body: (dailies != null)
            ? ListView.builder(
                itemCount: dailies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dailies[index].description),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditDailiesSales(dailies[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
