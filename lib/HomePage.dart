import 'package:flutter/material.dart';
import 'package:open_hospital_user/ExaminPage.dart';
import 'package:open_hospital_user/NextVisitPage.dart';
import 'package:open_hospital_user/PastVisitPage.dart';
import 'package:open_hospital_user/PatientPage.dart';
import 'package:open_hospital_user/models/examin.dart';
import 'package:open_hospital_user/models/operation.dart';
import 'package:open_hospital_user/models/therapy.dart';
import 'apiLogin.dart';
import 'api_connection.dart';
import 'package:http/http.dart' as http;
import 'models/patient.dart';
import 'models/opd.dart';
import 'package:intl/intl.dart'; //date formattater

class HomePage extends StatefulWidget {
  final String title;
  final Patient patient;
  final List<Examin> examin;
  final List<Therapy> therapy;
  final List<Opd> pastVisit;
  final List<Opd> futurevisit;
  final List<Operation> operation;
  HomePage(this.title, this.patient, this.examin, this.therapy, this.pastVisit,
      this.futurevisit, this.operation);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? getLastVisit() {
    String lastVisit = widget.pastVisit[0].visitDate.toString();
    for (var visit in widget.pastVisit) {
      if (DateTime.parse(visit.visitDate.toString())
          .isAfter(DateTime.parse(lastVisit))) {
        lastVisit = visit.visitDate.toString();
      }

      String lastVisitFormatted =
          DateFormat.yMMMd().format(DateTime.parse(lastVisit));
      return lastVisitFormatted;
    }
  }

  String? getLastOperation() {
    String lastOp = widget.operation[0].opDate.toString();
    for (var operation in widget.operation) {
      if (DateTime.parse(operation.opDate.toString())
          .isAfter(DateTime.parse(lastOp))) {
        lastOp = operation.opDate.toString();
      }
      String lastOpFormatted =
          DateFormat.yMMMd().format(DateTime.parse(lastOp));
      return lastOpFormatted;
    }
  }

  String? getLastExamin() {
    String lastEx = widget.examin[0].getDate();
    for (var examin in widget.examin) {
      if (DateTime.parse(examin.getDate()).isAfter(DateTime.parse(lastEx))) {
        lastEx = examin.getDate();
      }
      String lastExFormatted =
          DateFormat.yMMMd().format(DateTime.parse(lastEx));
      return lastExFormatted;
    }
  }

  List<DateTime> orderByDate() {
    List<DateTime> orderedFutureVisit = [];
    for (int i = 0; i < widget.futurevisit.length; i++) {
      orderedFutureVisit
          .add(DateTime.parse(widget.futurevisit[i].nextVisitDate.toString()));
    }
    orderedFutureVisit.sort((a, b) => a.compareTo(b));
    return orderedFutureVisit;
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> orderedFutureVisit = orderByDate();
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false, // rimuove il back button
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MY",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Image.asset("images/logo.png"),
              /*Text(
              widget.title,
              style: TextStyle(fontSize: 28, color: Colors.red),
            ),*/
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
///////////////////////////////////////////////BENVENUTO///////////////////////
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  "Benvenuto " + widget.patient.firstName.toString(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text("Abbiamo in archivio questi dati che ti riguardano",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PatientPage(
                              patient: widget.patient,
                            )));
                  },
                  child: Text(
                    "I TUOI DATI",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade800)),
                ),
/////////////////////////////////////////VISITE//////////////////////////////
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                    "Visite Effettuate: " +
                        widget.pastVisit.length
                            .toString(), //valore dinamico da recuperare
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 160,
                      child: Card(
                        color: Colors.grey.shade300,
                        child: Center(
                            child: Text(widget.pastVisit.length == 0
                                ? "Nessuna visita"
                                : "Ultima: " + getLastVisit().toString())),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    ElevatedButton(
                      onPressed: widget.pastVisit.length == 0
                          ? null
                          : () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PastVisitPage(widget.pastVisit)));
                            },
                      child: Text(
                        "Vedi tutte",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade800)),
                    )
                  ],
                ),
/////////////////////////////////////////OPERAZIONI//////////////////////////////
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                    "Operazioni Effettuate: " +
                        widget.operation.length
                            .toString(), //valore dinamico da recuperare
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 160,
                      child: Card(
                        child: Center(
                          child: Text(widget.operation.length == 0
                              ? "Nessuna operazione"
                              : "Ultima: " + getLastOperation().toString()),
                        ),
                        color: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    ElevatedButton(
                      onPressed: widget.operation.length == 0 ? null : () {},
                      child: Text(
                        "Vedi tutte",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade800)),
                    )
                  ],
                ),
/////////////////////////////////////////ESAMINAZIONI//////////////////////////////
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                    "Esaminazioni Effettuate: " +
                        widget.examin.length
                            .toString(), //valore dinamico da recuperare
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 160,
                      child: Card(
                        child: Center(
                          child: Text(widget.examin.length == 0
                              ? "Nessuna esaminazione"
                              : "Ultima: " + getLastExamin().toString()),
                        ),
                        color: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    ElevatedButton(
                      onPressed: widget.examin.length == 0
                          ? null
                          : () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ExaminPage(widget.examin)));
                            },
                      child: Text(
                        "Vedi tutte",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade800)),
                    ),
                  ],
                ),
/////////////////////////////////////////TERAPIE//////////////////////////////
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                    widget.therapy.length == 0
                        ? "Non hai terapie in corso"
                        : "Hai " +
                            widget.therapy.length.toString() +
                            " terapie in corso", //valore dinamico da recuperare
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                widget.therapy.length < 5
                    ? ListView.builder(
                        //scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.therapy.length,
                        itemBuilder: (context, index) => ExpansionTile(
                          //backgroundColor: Colors.red.shade800,
                          leading: IconTheme(
                              data:
                                  new IconThemeData(color: Colors.red.shade800),
                              child: new Icon(Icons.arrow_forward)),
                          title: Text(
                            "Terapia N°" +
                                widget.therapy[index].therapyID.toString(),
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Row(
                                children: [
                                  Icon(Icons.play_arrow),
                                  Text("Inizio: " +
                                      DateFormat.yMMMd().format(DateTime.parse(
                                          widget.therapy[index].startDate
                                              .toString()))),
                                  Padding(
                                      padding: EdgeInsets.only(right: 10.0)),
                                  Icon(Icons.close),
                                  Text("Fine: " +
                                      DateFormat.yMMMd().format(DateTime.parse(
                                          widget.therapy[index].endDate
                                              .toString()))),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text("Farmaco: " +
                                          widget.therapy[index].medicalId
                                              .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text("Quantità: " +
                                          widget.therapy[index].qty.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text("Frequenza giornaliera: " +
                                          widget.therapy[index].freqInDay
                                              .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text("Frequenza nel tempo: " +
                                          widget.therapy[index].freqInPeriod
                                              .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text("Note: " +
                                          widget.therapy[index].note
                                              .toString()),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            //scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.therapy.length,
                            itemBuilder: (context, index) => ExpansionTile(
                              //backgroundColor: Colors.red.shade800,
                              leading: IconTheme(
                                  data: new IconThemeData(
                                      color: Colors.red.shade800),
                                  child: new Icon(Icons.arrow_forward)),
                              title: Text(
                                "Terapia N°" +
                                    widget.therapy[index].therapyID.toString(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Row(
                                    children: [
                                      Icon(Icons.play_arrow),
                                      Text("Inizio: " +
                                          DateFormat.yMMMd().format(
                                              DateTime.parse(widget
                                                  .therapy[index].startDate
                                                  .toString()))),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(right: 10.0)),
                                      Icon(Icons.close),
                                      Text("Fine: " +
                                          DateFormat.yMMMd().format(
                                              DateTime.parse(widget
                                                  .therapy[index].endDate
                                                  .toString()))),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Farmaco: " +
                                          widget.therapy[index].medicalId
                                              .toString()),
                                      Text("Quantità: " +
                                          widget.therapy[index].qty.toString()),
                                      Text("Frequenza giornaliera: " +
                                          widget.therapy[index].freqInDay
                                              .toString()),
                                      Text("Frequenza nel tempo: " +
                                          widget.therapy[index].freqInPeriod
                                              .toString()),
                                      Text("Note: " +
                                          widget.therapy[index].note
                                              .toString()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Vedi Tutte",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.red.shade800),
                            ),
                          ),
                        ],
                      ),
/////////////////////////////////////////VISITE FUTURE//////////////////////////////
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                    widget.futurevisit.length == 0
                        ? "NON hai visite prenotate"
                        : "Hai " +
                            widget.futurevisit.length.toString() +
                            " visite prenotate", //valore dinamico da recuperare
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                widget.futurevisit.length < 5
                    ? ListView.builder(
                        //scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.futurevisit.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(DateFormat.yMMMMEEEEd()
                              .format(orderedFutureVisit[index])
                              .toString()),
                          subtitle: Text("Ore " +
                              DateFormat.Hm()
                                  .format(orderedFutureVisit[index])
                                  .toString()),
                          leading: IconTheme(
                              data:
                                  new IconThemeData(color: Colors.red.shade800),
                              child: new Icon(Icons.arrow_right_alt)),
                        ),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            //scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(DateFormat.yMMMMEEEEd()
                                  .format(orderedFutureVisit[index])
                                  .toString()),
                              subtitle: Text("Ore " +
                                  DateFormat.Hm()
                                      .format(orderedFutureVisit[index])
                                      .toString()),
                              leading: IconTheme(
                                  data: new IconThemeData(
                                      color: Colors.red.shade800),
                                  child: new Icon(Icons.arrow_right_alt)),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      NextVisitPage(widget.futurevisit)));
                            },
                            child: Text(
                              "Vedi Tutte",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.red.shade800),
                            ),
                          ),
                        ],
                      ),
                Padding(padding: EdgeInsets.all(15.0))
              ],
            ),
          ),
        ));
  }
}
