// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_null_comparison, unnecessary_new, prefer_const_constructors

import 'package:sucursales_app/models/sucursal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sucursal_provider.dart';

class EditSucursal extends StatefulWidget {
  final Sucursal sucursal;

  EditSucursal([this.sucursal]);

  @override
  _EditSucursalState createState() => _EditSucursalState();
}

class _EditSucursalState extends State<EditSucursal> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.sucursal == null) {
      //New Record
      nameController.text = "";
      phoneController.text = "";
      new Future.delayed(Duration.zero, () {
        final sucursalProvider =
            Provider.of<SucursalProvider>(context, listen: false);
        sucursalProvider.loadValues(Sucursal());
      });
    } else {
      //Controller Update
      nameController.text = widget.sucursal.name;
      phoneController.text = widget.sucursal.phone.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final sucursalProvider =
            Provider.of<SucursalProvider>(context, listen: false);
        sucursalProvider.loadValues(widget.sucursal);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sucursalProvider = Provider.of<SucursalProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Sucursal')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Sucursal Name'),
              onChanged: (value) {
                sucursalProvider.changeName(value);
              },
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(hintText: 'Sucursal Phone'),
              onChanged: (value) => sucursalProvider.changePhone(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                sucursalProvider.saveSucursal();
                Navigator.of(context).pop();
              },
            ),
            (widget.sucursal != null)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('Delete'),
                    onPressed: () {
                      sucursalProvider
                          .removeSucursal(widget.sucursal.sucursalId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
