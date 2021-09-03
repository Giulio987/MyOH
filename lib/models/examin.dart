class Examin {
  final int? pex_ID;
  final String? pex_date;
  final int? patientCode;
  final int? pex_height;
  final double? pex_weight;
  final int? pex_pa_min;
  final int? pex_pa_max;
  final int? pex_fc;
  final double? pex_temp;
  final double? pex_sat;
  final String? pex_note;

  Examin(
      {this.pex_ID,
      this.pex_date,
      this.patientCode,
      this.pex_height,
      this.pex_weight,
      this.pex_pa_min,
      this.pex_pa_max,
      this.pex_fc,
      this.pex_temp,
      this.pex_sat,
      this.pex_note});
  factory Examin.fromJson(Map<String, dynamic> json) {
    return Examin(
      pex_ID: json['pex_ID'],
      pex_date: json['pex_date'],
      patientCode: json['patientCode'],
      pex_height: json['pex_height	'],
      pex_weight: json['pex_weight'],
      pex_pa_min: json['pex_pa_min'],
      pex_pa_max: json['pex_pa_max'],
      pex_fc: json['pex_fc'],
      pex_temp: json['pex_temp'],
      pex_sat: json['pex_sat'],
      pex_note: json['pex_note'],
    );
  }
  @override
  String getDate() {
    return this.pex_date.toString();
  }
}
