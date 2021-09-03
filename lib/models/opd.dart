//CLASSE PER LE VISITE
class Opd {
  final int? code;
  final String? date;
  final String? visitDate;
  final String? nextVisitDate;
  final int? patientCode;
  final int? age;
  final String? sex;
  final String? note;
  //sul modello è un intero ma quì è necessario come stringa
  final int? prog_year;
  //AL MOMENTO COME MALATTIE VENGONO FATTI SEMPLICI MAP E NON ENTITA' A SE STANTI
  final Map<String, dynamic>? disease;
  final Map<String, dynamic>? disease2;
  final Map<String, dynamic>? disease3;
  final String? newPatient;
  final String? referralFrom;
  final String? referralTo;
  final String? userID;

  Opd({
    this.code,
    this.date,
    this.visitDate,
    this.nextVisitDate,
    this.patientCode,
    this.age,
    this.sex,
    this.note,
    this.prog_year,
    this.disease,
    this.disease2,
    this.disease3,
    this.newPatient,
    this.referralFrom,
    this.referralTo,
    this.userID,
  });
  factory Opd.fromJson(Map<String, dynamic> json) {
    return Opd(
      code: json['code'],
      date: json['date'],
      visitDate: json['visitDate'],
      nextVisitDate: json['nextVisitDate'],
      patientCode: json['patientCode'],
      age: json['age'],
      sex: json['sex'],
      note: json['note'],
      prog_year: json['prog_year'],
      disease: json['disease'],
      disease2: json['disease2'],
      disease3: json['disease3'],
      newPatient: json['newPatient'],
      referralFrom: json['referralFrom'],
      referralTo: json['referralTo'],
      userID: json['userID'],
    );
  }
}
