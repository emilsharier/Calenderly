class ProviderScheduleModel {
  String scheduleId, description, client_id;
  DateTime date, startTime, endTime;

  ProviderScheduleModel.fromJson(Map<String, dynamic> json) {
    this.scheduleId = json['schedule_id'].toString();
    this.description = json['description'];
    this.client_id = json['client_id'];
    this.date = DateTime.parse(json['date'].toString());
    this.startTime = DateTime.parse(
        json['date'].toString() + ' ' + json['start_time'].toString());
    this.endTime = DateTime.parse(
        json['date'].toString() + ' ' + json['end_time'].toString());
  }
}
