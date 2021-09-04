import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_hospital_user/models/opd.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class NextVisitPage extends StatelessWidget {
  final List<Opd> nextVisit;
  const NextVisitPage(this.nextVisit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Prossime Visite",
          style: TextStyle(
              color: Colors.red.shade800, fontWeight: FontWeight.bold),
        ),
      ),
      body: SfCalendar(
        dataSource: AppointmentDataSource(_getDataSource()),
        view: CalendarView.week,
        timeSlotViewSettings:
            TimeSlotViewSettings(timeInterval: Duration(hours: 2)),
        //showCurrentTimeIndicator: true,
      ),
    );
  }

  List<Appointment> _getDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    for (var visit in nextVisit) {
      final DateTime startVisit =
          DateTime.parse(visit.nextVisitDate.toString());
      final DateTime endVisit = startVisit.add(const Duration(hours: 2));
      appointments.add(Appointment(
          "Visit", startVisit, endVisit, const Color(0xFF0F8644), false));
    }
    return appointments;
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Appointment {
  Appointment(
      this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
