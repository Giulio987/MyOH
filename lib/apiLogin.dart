import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

final _base = "https://www.open-hospital.org/oh-api/auth/login?";
Map<String, String> header = {"Accept": "*/*"};

Future<Map<String, dynamic>> tryLogin(String userName, String passwd) async {
  final http.Response response;
  Map<String, dynamic> empty = {};
  String _baseLogin = _base + "password=" + userName + "&username=" + passwd;
  try {
    response = await http.post(Uri.parse(_baseLogin), headers: header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return empty;
    }
  } on Exception catch (e) {
    print(e);
    throw Exception();
  }
}
