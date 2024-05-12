// ignore_for_file: file_names

import 'dart:convert';

class OrderModel {
    final int? id;
    final int? customerId;
    final List<int>? sellers;
    final String? transactionId;
    final int? orderReferenceId;
    final dynamic paymentReferenceId;
    final List<int>? products;
    final double? totalAmount;
    final double? totalSystemAmount;
    final double? totalVendorsAmount;
    final double? tax;
    final String? customerName;
    final String? customerMobileNumber;
    final String? customerEmail;
    final String? alternativeNumber;
    final String? currencyCode;
    final String? state;
    final String? country;
    final String? address;
    final String? note;
    final double? shippingFees;
    final String? status;
    final String? paymentOption;
    final int? lastModifiedDate;
    final int? createdDate;

    OrderModel({
        this.id,
        this.customerId,
        this.sellers,
        this.transactionId,
        this.orderReferenceId,
        this.paymentReferenceId,
        this.products,
        this.totalAmount,
        this.totalSystemAmount,
        this.totalVendorsAmount,
        this.tax,
        this.customerName,
        this.customerMobileNumber,
        this.customerEmail,
        this.alternativeNumber,
        this.currencyCode,
        this.state,
        this.country,
        this.address,
        this.note,
        this.shippingFees,
        this.status,
        this.paymentOption,
        this.lastModifiedDate,
        this.createdDate,
    });

    OrderModel copyWith({
        int? id,
        int? customerId,
        List<int>? sellers,
        String? transactionId,
        int? orderReferenceId,
        dynamic paymentReferenceId,
        List<int>? products,
        double? totalAmount,
        double? totalSystemAmount,
        double? totalVendorsAmount,
        double? tax,
        String? customerName,
        String? customerMobileNumber,
        String? customerEmail,
        String? alternativeNumber,
        String? currencyCode,
        String? state,
        String? country,
        String? address,
        String? note,
        double? shippingFees,
        String? status,
        String? paymentOption,
        int? lastModifiedDate,
        int? createdDate,
    }) => 
        OrderModel(
            id: id ?? this.id,
            customerId: customerId ?? this.customerId,
            sellers: sellers ?? this.sellers,
            transactionId: transactionId ?? this.transactionId,
            orderReferenceId: orderReferenceId ?? this.orderReferenceId,
            paymentReferenceId: paymentReferenceId ?? this.paymentReferenceId,
            products: products ?? this.products,
            totalAmount: totalAmount ?? this.totalAmount,
            totalSystemAmount: totalSystemAmount ?? this.totalSystemAmount,
            totalVendorsAmount: totalVendorsAmount ?? this.totalVendorsAmount,
            tax: tax ?? this.tax,
            customerName: customerName ?? this.customerName,
            customerMobileNumber: customerMobileNumber ?? this.customerMobileNumber,
            customerEmail: customerEmail ?? this.customerEmail,
            alternativeNumber: alternativeNumber ?? this.alternativeNumber,
            currencyCode: currencyCode ?? this.currencyCode,
            state: state ?? this.state,
            country: country ?? this.country,
            address: address ?? this.address,
            note: note ?? this.note,
            shippingFees: shippingFees ?? this.shippingFees,
            status: status ?? this.status,
            paymentOption: paymentOption ?? this.paymentOption,
            lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
            createdDate: createdDate ?? this.createdDate,
        );

    factory OrderModel.fromJson(String str) => OrderModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        customerId: json["customerId"],
        sellers: json["sellers"] == null ? [] : List<int>.from(json["sellers"]!.map((x) => x)),
        transactionId: json["transactionId"],
        orderReferenceId: json["orderReferenceId"],
        paymentReferenceId: json["paymentReferenceId"],
        products: json["products"] == null ? [] : List<int>.from(json["products"]!.map((x) => x)),
        totalAmount: json["totalAmount"]?.toDouble(),
        totalSystemAmount: json["totalSystemAmount"]?.toDouble(),
        totalVendorsAmount: json["totalVendorsAmount"]?.toDouble(),
        tax: json["tax"],
        customerName: json["customerName"],
        customerMobileNumber: json["customerMobileNumber"],
        customerEmail: json["customerEmail"],
        alternativeNumber: json["alternativeNumber"],
        currencyCode: json["currencyCode"],
        state: json["state"],
        country: json["country"],
        address: json["address"],
        note: json["note"],
        shippingFees: json["shippingFees"]?.toDouble(),
        status: json["status"],
        paymentOption: json["paymentOption"],
        lastModifiedDate: json["lastModifiedDate"],
        createdDate: json["createdDate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "customerId": customerId,
        "sellers": sellers == null ? [] : List<dynamic>.from(sellers!.map((x) => x)),
        "transactionId": transactionId,
        "orderReferenceId": orderReferenceId,
        "paymentReferenceId": paymentReferenceId,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
        "totalAmount": totalAmount,
        "totalSystemAmount": totalSystemAmount,
        "totalVendorsAmount": totalVendorsAmount,
        "tax": tax,
        "customerName": customerName,
        "customerMobileNumber": customerMobileNumber,
        "customerEmail": customerEmail,
        "alternativeNumber": alternativeNumber,
        "currencyCode": currencyCode,
        "state": state,
        "country": country,
        "address": address,
        "note": note,
        "shippingFees": shippingFees,
        "status": status,
        "paymentOption": paymentOption,
        "lastModifiedDate": lastModifiedDate,
        "createdDate": createdDate,
    };
}
