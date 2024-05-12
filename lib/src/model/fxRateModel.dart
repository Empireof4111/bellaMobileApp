// ignore_for_file: file_names

import 'dart:convert';

class FxRateModel {
    final int? id;
    final String? fromCode;
    final String? toCode;
    final double? rate;
    final bool? isUpdated;
    final String? lastUpdatedBy;
    final int? lastUpdatedDate;
    final int? createdDate;

    FxRateModel({
        this.id,
        this.fromCode,
        this.toCode,
        this.rate,
        this.isUpdated,
        this.lastUpdatedBy,
        this.lastUpdatedDate,
        this.createdDate,
    });

    FxRateModel copyWith({
        int? id,
        String? fromCode,
        String? toCode,
        double? rate,
        bool? isUpdated,
        String? lastUpdatedBy,
        int? lastUpdatedDate,
        int? createdDate,
    }) => 
        FxRateModel(
            id: id ?? this.id,
            fromCode: fromCode ?? this.fromCode,
            toCode: toCode ?? this.toCode,
            rate: rate ?? this.rate,
            isUpdated: isUpdated ?? this.isUpdated,
            lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
            lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
            createdDate: createdDate ?? this.createdDate,
        );

    factory FxRateModel.fromJson(String str) => FxRateModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FxRateModel.fromMap(Map<String, dynamic> json) => FxRateModel(
        id: json["id"],
        fromCode: json["fromCode"],
        toCode: json["toCode"],
        rate: json["rate"]?.toDouble(),
        isUpdated: json["isUpdated"],
        lastUpdatedBy: json["lastUpdatedBy"],
        lastUpdatedDate: json["lastUpdatedDate"],
        createdDate: json["createdDate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "fromCode": fromCode,
        "toCode": toCode,
        "rate": rate,
        "isUpdated": isUpdated,
        "lastUpdatedBy": lastUpdatedBy,
        "lastUpdatedDate": lastUpdatedDate,
        "createdDate": createdDate,
    };
}
