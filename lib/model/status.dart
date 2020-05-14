class Status {
  String domain;
  String zone;
  String status;
  String summary;

  Status({this.domain, this.zone, this.status, this.summary});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      domain: json["domain"],
      zone: json["zone"],
      status: json["status"],
      summary: json["summary"],
    );
  }
}

class StatusList {
  final List<Status> statuses;

  StatusList({this.statuses});

  factory StatusList.fromJson(List<dynamic> parsedJson) {
    return StatusList(
        statuses: parsedJson.map((value) => Status.fromJson(value)).toList());
  }
}
