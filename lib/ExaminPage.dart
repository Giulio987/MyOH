import 'package:flutter/material.dart';
import 'package:open_hospital_user/models/examin.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:intl/intl.dart';

class ExaminPage extends StatelessWidget {
  final List<Examin> examin;
  const ExaminPage(this.examin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Esaminazioni",
          style: TextStyle(
              color: Colors.red.shade800, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: examin.length,
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
                      .format(DateTime.parse(examin[index].pex_date.toString()))
                      .toString(),
                  style: TextStyle(
                    fontSize: 18,
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
                  "Altezza: " + examin[index].pex_height.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Larghezza: " + examin[index].pex_weight.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "Pressione sangue MIN: " +
                      examin[index].pex_pa_min.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "Pressione sangue MAX: " +
                      examin[index].pex_pa_max.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "Frequenza cardiaca: " + examin[index].pex_fc.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "Temperatura: " + examin[index].pex_temp!.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "Saturazione: " + examin[index].pex_sat.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "Note: " + examin[index].pex_note.toString(),
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
