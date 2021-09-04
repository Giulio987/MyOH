import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:intl/intl.dart';
import 'package:open_hospital_user/models/operation.dart';

class OperationPage extends StatelessWidget {
  final List<Operation> op;
  const OperationPage(this.op);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Operazioni",
          style: TextStyle(
              color: Colors.red.shade800, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: op.length,
        itemBuilder: (context, index) => ExpansionCard(
          trailing: IconTheme(
              data: new IconThemeData(color: Colors.red.shade800),
              child: new Icon(Icons.arrow_drop_down)),
          leading: IconTheme(
              data: new IconThemeData(color: Colors.red.shade800),
              child: new Icon(Icons.event)),
          borderRadius: 20,
          backgroundColor: Colors.grey.shade300,
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat.yMMMMEEEEd()
                      .format(DateTime.parse(op[index].opDate.toString()))
                      .toString(),
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Descrizione: " + op[index].description.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Risultato: " + op[index].opResult.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "Tipo: " + op[index].type!['description'].toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
