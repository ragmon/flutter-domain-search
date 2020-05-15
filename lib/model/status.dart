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

class StatusError {
  int code;
  String message;
  String details;

  StatusError({this.code, this.message, this.details});

  factory StatusError.fromJson(Map<String, dynamic> json) {
    return StatusError(
      code: json["code"],
      message: json["message"],
      details: json["details"],
    );
  }
}

class StatusErrorList {
  final List<StatusError> statusErrors;

  StatusErrorList({this.statusErrors});

  factory StatusErrorList.fromJson(List<dynamic> parsedJson) {
    return StatusErrorList(
        statusErrors:
            parsedJson.map((value) => StatusError.fromJson(value)).toList());
  }
}
