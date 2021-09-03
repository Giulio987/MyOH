import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_hospital_user/models/operation.dart';
import 'package:open_hospital_user/models/opd.dart';
import 'package:open_hospital_user/models/therapy.dart';
import './models/patient.dart';
import './models/examin.dart';

//ONLY VM
//Platform.isAndroid
//  ? "http://10.0.2.2:8080/oh-api/patients"
String _base = "https://www.open-hospital.org/oh-api/patients";
Uri _tokenURL = Uri.parse(_base);
Map<String, String> header = {};

void setHeaderPatient(String token) {
  String auth = "Bearer " + token;
  header = {
    "accept": "application/json; charset=UTF-8",
    "content-type": "application/json",
    'authorization': auth,
  };
}

Future<Patient> fetchPatient(http.Client client, String code) async {
  _base = "https://www.open-hospital.org/oh-api/patients";
  _tokenURL = Uri.parse(_base);
  String _singlePatient = _tokenURL.toString() + "/" + code;
  //print(_singlePatient);
  var p = Patient(
      firstName: "",
      secondName: "",
      birthDate: null,
      age: null,
      agetype: null,
      sex: null,
      city: null,
      bloodType: null);
  try {
    final http.Response response = await http.get(
      Uri.parse(_singlePatient),
      headers: header,
    );
    try {
      if (response.statusCode == 200) {
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        print(response.headers);
        //print(jsonDecode(response.body));
        return p;
      }
    } on FormatException catch (ex) {
      return p;
    }
  } on SocketException catch (e) {
    return p;
  }
}

List<Examin> examinFromJson(String str) {
  final parsed = jsonDecode(str).cast<Map<String, dynamic>>();
  return parsed.map<Examin>((json) => Examin.fromJson(json)).toList();
}

Future<List<Examin>> fetchExamin(http.Client client, String code) async {
  _base =
      "https://www.open-hospital.org/oh-api/examinations/byPatientId/" + code;
  _tokenURL = Uri.parse(_base);
  List<Examin> m = [];
  try {
    final http.Response response = await http.get(
      _tokenURL,
      headers: header,
    );
    if (response.statusCode == 200) {
      return examinFromJson(response.body);
    } else {
      print(response.headers);
      print(response.body);
      throw Exception(); //managed on the main page
    }
  } on SocketException catch (e) {
    return m;
  }
}

List<Therapy> thearpyFromJson(String str) {
  final parsed = jsonDecode(str).cast<Map<String, dynamic>>();
  return parsed.map<Therapy>((json) => Therapy.fromJson(json)).toList();
}

Future<List<Therapy>> fetchThreapy(http.Client client, String code) async {
  _base = "https://www.open-hospital.org/oh-api/therapies/" + code;
  _tokenURL = Uri.parse(_base);
  List<Therapy> m = [];
  try {
    final http.Response response = await http.get(
      _tokenURL,
      headers: header,
    );
    if (response.statusCode == 200) {
      return thearpyFromJson(response.body);
    } else {
      print(response.headers);
      print(response.body);
      throw Exception(); //managed on the main page
    }
  } on SocketException catch (e) {
    return m;
  }
}

List<Opd> visitFromJson(String str) {
  final parsed = jsonDecode(str).cast<Map<String, dynamic>>();
  return parsed.map<Opd>((json) => Opd.fromJson(json)).toList();
}

Future<List<Opd>> fetchVisit(http.Client client, String code) async {
  _base = "https://www.open-hospital.org/oh-api/opds/patient/" + code;
  _tokenURL = Uri.parse(_base);
  List<Opd> m = [];
  try {
    final http.Response response = await http.get(
      _tokenURL,
      headers: header,
    );
    if (response.statusCode == 200) {
      return visitFromJson(response.body);
    } else {
      print(response.headers);
      print(response.body);
      throw Exception(); //managed on the main page
    }
  } on SocketException catch (e) {
    return m;
  }
}

List<Operation> opFromJson(String str) {
  final parsed = jsonDecode(str).cast<Map<String, dynamic>>();
  return parsed.map<Operation>((json) => Operation.fromJson(json)).toList();
}

//IN realtà ritorna tutta "l'ammissione del paziente" ma qui interessano solo i dati di operazioni
Future<List<Operation>> fetchOperation(http.Client client, String code) async {
  _base = "https://www.open-hospital.org/oh-api/admissions?patientcode=" + code;
  _tokenURL = Uri.parse(_base);
  List<Operation> m = [];
  try {
    final http.Response response = await http.get(
      _tokenURL,
      headers: header,
    );
    if (response.statusCode == 200) {
      return opFromJson(response.body);
    } else {
      return m;
    }
  } on SocketException catch (e) {
    return m;
  }
}
