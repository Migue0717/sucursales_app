// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_null_comparison, unnecessary_new, prefer_const_constructors

import 'package:sucursales_app/models/dailies_sales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucursales_app/providers/dailies_provider.dart';

class EditDailiesSales extends StatefulWidget {
  final DailiesSales dailies;

  EditDailiesSales([this.dailies]);

  @override
  _EditDailiesState createState() => _EditDailiesState();
}

class _EditDailiesState extends State<EditDailiesSales> {
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final netValueController = TextEditingController();
  final grossValueController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    quantityController.dispose();
    netValueController.dispose();
    grossValueController.dispose();
    super.dispose();
  }

  @override
  void initSate() {
    if (widget.dailies == null) {
      // Add new daily
      descriptionController.text = "";
      quantityController.text = "";
      netValueController.text = "";
      grossValueController.text = "";
      new Future.delayed(Duration.zero, () {
        final dailiesProvider =
            Provider.of<DailiesProvider>(context, listen: false);
        dailiesProvider.loadValues(DailiesSales());
      });
    } else {
      // Controller update
      descriptionController.text = widget.dailies.description;
      quantityController.text = widget.dailies.quantity.toString();
      netValueController.text = widget.dailies.netValue.toString();
      grossValueController.text = widget.dailies.grossValue.toString();
      //State update
      new Future.delayed(Duration.zero, () {
        final dailiesProvider =
            Provider.of<DailiesProvider>(context, listen: false);
        dailiesProvider.loadValues(widget.dailies);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dailiesProvider = Provider.of<DailiesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Daily')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Daily description'),
              onChanged: (value) {
                dailiesProvider.changeDescription(value);
              },
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(hintText: 'Daily quantity'),
              onChanged: (value) {
                dailiesProvider.changeQuantity(value);
              },
            ),
            TextField(
              controller: netValueController,
              decoration: InputDecoration(hintText: 'Daily netValue'),
              onChanged: (value) {
                dailiesProvider.changeNetValue(value);
              },
            ),
            TextField(
              controller: grossValueController,
              decoration: InputDecoration(hintText: 'Daily grossValue'),
              onChanged: (value) {
                dailiesProvider.changeGrossValue(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                dailiesProvider.saveDailies();
                Navigator.of(context).pop();
              },
            ),
            (widget.dailies != null)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('Delete'),
                    onPressed: () {
                      dailiesProvider.removeDailies(widget.dailies.sucursalId);
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
