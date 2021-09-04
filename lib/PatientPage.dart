import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import './api_connection.dart';
import './models/patient.dart';

class PatientPage extends StatelessWidget {
  final Patient? patient;
  PatientPage({this.patient});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    //print(deviceWidth);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Paziente " + patient!.code.toString(),
          style: TextStyle(
            color: Colors.red.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: deviceWidth > 1000
          ? LargeScreenDataList(patient: patient)
          //data columns and row adapting for small screen size
          : SmallScreenDataList(patient: patient),
    );
  }
}

class LargeScreenDataList extends StatelessWidget {
  final Patient? patient;
  const LargeScreenDataList({Key? key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(15.0)),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    "Code",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Name",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Surname",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Birth Date",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Age",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Sex",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "City",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Blood t.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Telephone",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Note",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Mother",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Father",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Tax Code",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    Center(
                      child: Text(
                        patient!.code.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.firstName.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.secondName.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.birthDate.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.age.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.sex.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.city.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.bloodType.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.telephone.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.note.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.mother.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.father.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        patient!.taxCode.toString(),
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SmallScreenDataList extends StatelessWidget {
  final Patient? patient;
  const SmallScreenDataList({Key? key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: DataTable(
          columns: [
            DataColumn(label: Text("INFORMATION")),
            DataColumn(label: Text(" ")),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Code:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.code.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Name:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.firstName.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Surname:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.secondName.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Birth Date:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    DateFormat.yMMMd()
                        .format(DateTime.parse(patient!.birthDate.toString()))
                        .toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Sex:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.sex.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Address:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.address.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "City:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.city.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Telephone:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.telephone.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Mother Name:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.mother_name.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Note:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.note.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Mother:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.mother.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Father Name:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.father.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text(
                    "Tax code:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    patient!.taxCode.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
