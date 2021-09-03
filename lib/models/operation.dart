/* class Admission {
  final String abortDate;
  final String ctrlDate1;
  final String ctrlDate2;
  final String fhu;
  final int id;
  final int admitted;
  final String type;
  //NON VENGONO GESTITE ENTITA' NON UTILI
  final Map<String, dynamic> ward;
  final int yProg;
  final int patient;
  final String admDate;
  final Map<String, dynamic> admType;
  final Map<String, dynamic> diseaseIn;
  final Map<String, dynamic> diseaseOut1;
  final Map<String, dynamic> diseaseOut2;
  final Map<String, dynamic> diseaseOut3;
  final Map<String, dynamic> operation;
  final String opDate;
  final String opResult;
  final String disDate;
  final Map<String, dynamic> disType;
  final 
} */
class Operation {
  final String? code;
  final String? description;
  final String? opDate;
  final String? opResult;
  final int? lock;
  final int? major;
  final Map<String, dynamic>? type;

  Operation({
    this.code,
    this.description,
    this.opDate,
    this.opResult,
    this.lock,
    this.major,
    this.type,
  });
  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      code: json['operation']['code'],
      description: json['operation']['description'],
      opDate: json['opDate'],
      opResult: json['opResult'],
      lock: json['operation']['lock'],
      major: json['operation']['major'],
      type: json['operation']['type'],
    );
  }
}
