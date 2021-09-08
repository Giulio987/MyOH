import 'package:flutter/material.dart';
import 'models/opd.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:intl/intl.dart'; //date formattater

class PastVisitPage extends StatelessWidget {
  final List<Opd> pastVisit;
  const PastVisitPage(this.pastVisit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Visite Passate",
          style: TextStyle(
              color: Colors.red.shade800, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: pastVisit.length,
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
                      .format(
                          DateTime.parse(pastVisit[index].visitDate.toString()))
                      .toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Next: " +
                      DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(
                              pastVisit[index].nextVisitDate.toString()))
                          .toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Malattia primaria: " +
                      pastVisit[index].disease!['description'].toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  pastVisit[index].disease2 == null
                      ? "Non ci sono cause secondarie"
                      : "Causa secondaria: " +
                          pastVisit[index].disease2!['description'].toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  pastVisit[index].disease3 == null
                      ? ""
                      : "Altra maattia: " +
                          pastVisit[index].disease3!['description'].toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
