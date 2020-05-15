class StatusModel {
  String domain;
  String zone;
  String status;
  String summary;

  StatusModel({this.domain, this.zone, this.status, this.summary});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      domain: json["domain"],
      zone: json["zone"],
      status: json["status"],
      summary: json["summary"],
    );
  }
}

class StatusListModel {
  final List<StatusModel> statuses;

  StatusListModel({this.statuses});

  factory StatusListModel.fromJson(List<dynamic> parsedJson) {
    return StatusListModel(
        statuses: parsedJson.map((value) => StatusModel.fromJson(value)).toList());
  }
}

class StatusErrorModel {
  int code;
  String message;
  String detail;

  StatusErrorModel({this.code, this.message, this.detail});

  factory StatusErrorModel.fromJson(Map<String, dynamic> json) {
    return StatusErrorModel(
      code: json["code"],
      message: json["message"],
      detail: json["detail"],
    );
  }
}

class StatusErrorList {
  final List<StatusErrorModel> statusErrors;

  StatusErrorList({this.statusErrors});

  factory StatusErrorList.fromJson(List<dynamic> parsedJson) {
    return StatusErrorList(
        statusErrors:
            parsedJson.map((value) => StatusErrorModel.fromJson(value)).toList());
  }
}
