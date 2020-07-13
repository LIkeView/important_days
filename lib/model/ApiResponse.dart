// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.resCode,
    this.resMessage,
    this.resData,
  });

  int resCode;
  String resMessage;
  ResData resData;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    resCode: json["res_code"],
    resMessage: json["res_message"],
    resData: ResData.fromJson(json["res_data"]),
  );

  Map<String, dynamic> toJson() => {
    "res_code": resCode,
    "res_message": resMessage,
    "res_data": resData.toJson(),
  };
}

class ResData {
  ResData({
    this.festivalDetails,
  });

  List<FestivalDetail> festivalDetails;

  factory ResData.fromJson(Map<String, dynamic> json) => ResData(
    festivalDetails: List<FestivalDetail>.from(json["festival_details"].map((x) => FestivalDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "festival_details": List<dynamic>.from(festivalDetails.map((x) => x.toJson())),
  };
}

class FestivalDetail {
  FestivalDetail({
    this.festivalId,
    this.fesId,
    this.date,
    this.fesName,
    this.fesCat,
    this.tags,
    this.mDate,
  });

  String festivalId;
  String fesId;
  String date;
  String fesName;
  String fesCat;
  String tags;
  MDate mDate;

  factory FestivalDetail.fromJson(Map<String, dynamic> json) => FestivalDetail(
    festivalId: json["festival_id"],
    fesId: json["fes_id"],
    date: json["date"],
    fesName: json["fes_name"],
    fesCat: json["fes_cat"],
    tags: json["tags"],
    mDate: mDateValues.map[json["m_date"]],
  );

  Map<String, dynamic> toJson() => {
    "festival_id": festivalId,
    "fes_id": fesId,
    "date": date,
    "fes_name": fesName,
    "fes_cat": fesCat,
    "tags": tags,
    "m_date": mDateValues.reverse[mDate],
  };
}

enum MDate { SEPTEMBER_01 }

final mDateValues = EnumValues({
  "September-01": MDate.SEPTEMBER_01
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
