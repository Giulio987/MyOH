class Therapy {
  final int? therapyID;
//NON è necessario fare l'associazione con il modello Paziente per ora
  final int? patID;
  final String? startDate;
  final String? endDate;
  final int? medicalId;
  final double? qty;
  final int? unitId;
  final int? freqInDay;
  final int? freqInPeriod;
  final String? note;
  final int? notifyInt;
  final int? smsInt;

  Therapy(
      {this.therapyID,
      this.patID,
      this.startDate,
      this.endDate,
      this.medicalId,
      this.qty,
      this.unitId,
      this.freqInDay,
      this.freqInPeriod,
      this.note,
      this.notifyInt,
      this.smsInt});
  factory Therapy.fromJson(Map<String, dynamic> json) {
    return Therapy(
      therapyID: json['therapyID'],
      patID: json['therapyID'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      medicalId: json['medicalId'],
      qty: json['qty'],
      unitId: json['unitID'],
      freqInDay: json['freqInDay'],
      freqInPeriod: json['freqInPeriod'],
      note: json['note'],
      notifyInt: json['notifyInt'],
      smsInt: json['smsInt'],
    );
  }
}
