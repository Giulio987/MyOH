import 'package:flutter/material.dart';
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
import 'HomePage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.red.shade800),
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
    //debugShowCheckedModeBanner: false, //per rimuovere la scritta debug
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  Map<String, dynamic> credentials = {};
//Possibile controllo Login Futuro
  void fakeLogin() async {
    /*void login() async {
    credentials =
        await tryLogin(userNameController.text, passwordController.text);
    
    if (credentials.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Wrong Credentials"),
            content: new Text("Try again"),
          );
        },
      );
    } else {*/
    if (userNameController.text == "" || passwordController.text == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Fill all the fields"),
            content: new Text("Try again"),
          );
        },
      );
    } else {
      //visto che il login non c'è al momento vengono passati già i codici
      //necessari al recupero dei dati
      Map<String, dynamic> credentials = await tryLogin("admin", "admin");
      setHeaderPatient(credentials['token']);
      //Dopo aver ottenuto il token verrà passato l'dentificatore del paziente
      //al momento il paziente è quello con codice 541
      Patient p = await fetchPatient(http.Client(), "541");
      //recupero le visite
      List<Opd> visit = await fetchVisit(http.Client(), p.code.toString());
      //recupero le visite passate
      List<Opd> pastVisit = getPastVisits(visit);
      //recupero solo le visite future
      List<Opd> futureVisit = getFutureVisits(visit);
      //Recupero le operazioni
      List<Operation> operation =
          await fetchOperation(http.Client(), p.code.toString());
      //recupero le esaminazioni a esso associate
      List<Examin> examin = await fetchExamin(http.Client(), p.code.toString());
      //recupero le terapie
      List<Therapy> therapy =
          await fetchThreapy(http.Client(), p.code.toString());
      List<Therapy> currentTherapy = getTherapy(therapy);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage("My OH", p, examin, currentTherapy,
              pastVisit, futureVisit, operation),
        ),
      ); //credentials['displayName'])));
    }
  }

  //Controllo se le visite future nn sono già passate
  List<Opd> getFutureVisits(List<Opd> vis) {
    final now = DateTime.now();
    List<Opd> formattedVisit = [];
    for (var visit in vis) {
      if (DateTime.parse(visit.nextVisitDate.toString()).isAfter(now)) {
        formattedVisit.add(visit);
      }
    }
    return formattedVisit;
  }

  List<Therapy> getTherapy(List<Therapy> ther) {
    final now = DateTime.now();
    List<Therapy> formattedTherapy = [];
    for (var therapy in ther) {
      if (DateTime.parse(therapy.endDate.toString()).isAfter(now)) {
        formattedTherapy.add(therapy);
      }
    }
    return formattedTherapy;
  }

  List<Opd> getPastVisits(List<Opd> vis) {
    final now = DateTime.now();
    List<Opd> formattedVisit = [];
    for (var visit in vis) {
      if (DateTime.parse(visit.nextVisitDate.toString()).isBefore(now)) {
        formattedVisit.add(visit);
      }
    }
    return formattedVisit;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* Container(
                    width: deviceWidth < 500 //small screen
                        ? deviceWidth * 0.65
                        : (deviceWidth < 1100
                            ? deviceWidth * 0.4 //Medium screen
                            : deviceWidth * 0.25), //Large Screen
                    height: deviceHeight * 0.2, //200,
                    child: Row(
                      children: [
                        Text(
                          "MY",
                          style: TextStyle(
                              fontSize: deviceWidth < 500 //small screen
                                  ? deviceWidth * 0.17
                                  : (deviceWidth < 1100
                                      ? deviceWidth * 0.12 //Medium screen
                                      : deviceWidth * 0.07), //Large Screen
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          "images/OH.png",
                          width: deviceWidth < 500 //small screen
                              ? deviceWidth * 0.35
                              : (deviceWidth < 1100
                                  ? deviceWidth * 0.2 //Medium screen
                                  : deviceWidth * 0.12), //Large Screen
                          height: deviceHeight * 0.2,
                        ),
                      ],
                    ),
                  ), */
          Container(
            width: 300,
            //height: 150,
            child: Image.asset(
              "images/MyOH.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(padding: EdgeInsets.all(deviceHeight < 800 ? 5.0 : 20.0)),
          Container(
            width: 300,
            child: TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username'),
              keyboardType: TextInputType.text,
              controller: userNameController,
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          Container(
            width: 300,
            child: TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password'),
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          Padding(padding: EdgeInsets.all(20.0)),
          ElevatedButton(
            onPressed: fakeLogin,
            child: Text(
              "Enter",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.red.shade800)),
          ),
        ],
      ),
    ));
  }
}
