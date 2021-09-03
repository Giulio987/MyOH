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
            color: Colors.red.shade800,
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: pastVisit.length,
          itemBuilder: (context, index) => ExpansionCard(
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
                    "Visita del " +
                        DateFormat.yMMMMEEEEd()
                            .format(DateTime.parse(
                                pastVisit[index].visitDate.toString()))
                            .toString(),
                    style: TextStyle(
                      fontSize: 25,
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
                    "Causa primaria: " +
                        pastVisit[index].disease!['description'].toString(),
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Text(
                    pastVisit[index].disease2 == null
                        ? "Non ci sono cause secondarie"
                        : "Causa secondaria: " +
                            pastVisit[index]
                                .disease2!['description']
                                .toString(),
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Text(
                    pastVisit[index].disease3 == null
                        ? "Non ci sono altre cause"
                        : "Altra causa: " +
                            pastVisit[index]
                                .disease3!['description']
                                .toString(),
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
