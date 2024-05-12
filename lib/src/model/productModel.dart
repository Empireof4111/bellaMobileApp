// ignore_for_file: file_names

import 'dart:convert';


enum ProductType { all, watch, mobile, headphone, tablet, tv }

//NEW PRODUCT MODEL

class Product {
    final int? id;
    final int? vendorId;
    final String? vendorName;
    final int? categoryId;
    final String? currencyCode;
    final String? categoryName;
    final int? subCategoryId;
    final String? subCategoryName;
    final String? name;
    final String? brand;
    final String? unit;
    final dynamic source;
    final String? sizes;
    final String? colors;
    final String? status;
    final String? description;
    final String? fullDescription;
    final String? features;
    final double? price;
    final double? vendorPrice;
    final double? shippingFees;
    final double? serviceCharge;
    final String? serviceChargeMode;
    final String? serviceChargeType;
    final dynamic ratings;
    final dynamic reviews;
    final int? stock;
    final String? images;
    final String? thumbnail;
    final dynamic remark;
    final int? lastModifiedDate;
    final int? createdDate;

    Product({
        this.id,
        this.vendorId,
        this.vendorName,
        this.categoryId,
        this.currencyCode,
        this.categoryName,
        this.subCategoryId,
        this.subCategoryName,
        this.name,
        this.brand,
        this.unit,
        this.source,
        this.sizes,
        this.colors,
        this.status,
        this.description,
        this.fullDescription,
        this.features,
        this.price,
        this.vendorPrice,
        this.shippingFees,
        this.serviceCharge,
        this.serviceChargeMode,
        this.serviceChargeType,
        this.ratings,
        this.reviews,
        this.stock,
        this.images,
        this.thumbnail,
        this.remark,
        this.lastModifiedDate,
        this.createdDate,
    });

    Product copyWith({
        int? id,
        int? vendorId,
        String? vendorName,
        int? categoryId,
        String? currencyCode,
        String? categoryName,
        int? subCategoryId,
        String? subCategoryName,
        String? name,
        String? brand,
        String? unit,
        dynamic source,
        String? sizes,
        String? colors,
        String? status,
        String? description,
        String? fullDescription,
        String? features,
        double? price,
        double? vendorPrice,
        double? shippingFees,
        double? serviceCharge,
        String? serviceChargeMode,
        String? serviceChargeType,
        dynamic ratings,
        dynamic reviews,
        int? stock,
        String? images,
        String? thumbnail,
        dynamic remark,
        int? lastModifiedDate,
        int? createdDate,
    }) => 
        Product(
            id: id ?? this.id,
            vendorId: vendorId ?? this.vendorId,
            vendorName: vendorName ?? this.vendorName,
            categoryId: categoryId ?? this.categoryId,
            currencyCode: currencyCode ?? this.currencyCode,
            categoryName: categoryName ?? this.categoryName,
            subCategoryId: subCategoryId ?? this.subCategoryId,
            subCategoryName: subCategoryName ?? this.subCategoryName,
            name: name ?? this.name,
            brand: brand ?? this.brand,
            unit: unit ?? this.unit,
            source: source ?? this.source,
            sizes: sizes ?? this.sizes,
            colors: colors ?? this.colors,
            status: status ?? this.status,
            description: description ?? this.description,
            fullDescription: fullDescription ?? this.fullDescription,
            features: features ?? this.features,
            price: price ?? this.price,
            vendorPrice: vendorPrice ?? this.vendorPrice ,
            shippingFees: shippingFees ?? this.shippingFees,
            serviceCharge: serviceCharge ?? this.serviceCharge,
            serviceChargeMode: serviceChargeMode ?? this.serviceChargeMode,
            serviceChargeType: serviceChargeType ?? this.serviceChargeType,
            ratings: ratings ?? this.ratings,
            reviews: reviews ?? this.reviews,
            stock: stock ?? this.stock,
            images: images ?? this.images,
            thumbnail: thumbnail ?? this.thumbnail,
            remark: remark ?? this.remark,
            lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
            createdDate: createdDate ?? this.createdDate,
        );

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        vendorId: json["vendorId"],
        vendorName: json["vendorName"],
        categoryId: json["categoryId"],
        currencyCode: json["currencyCode"],
        categoryName: json["categoryName"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        name: json["name"],
        brand: json["brand"],
        unit: json["unit"],
        source: json["source"],
        sizes: json["sizes"],
        colors: json["colors"],
        status: json["status"],
        description: json["description"],
        fullDescription: json["fullDescription"],
        features: json["features"],
        price: json["price"],
        vendorPrice: json["vendorPrice"],
        shippingFees: json["shippingFees"],
        serviceCharge: json["serviceCharge"],
        serviceChargeMode: json["serviceChargeMode"],
        serviceChargeType: json["serviceChargeType"],
        ratings: json["ratings"],
        reviews: json["reviews"],
        stock: json["stock"],
        images: json["images"],
        thumbnail: json["thumbnail"],
        remark: json["remark"],
        lastModifiedDate: json["lastModifiedDate"],
        createdDate: json["createdDate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "vendorId": vendorId,
        "vendorName": vendorName,
        "categoryId": categoryId,
        "currencyCode": currencyCode,
        "categoryName": categoryName,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "name": name,
        "brand": brand,
        "unit": unit,
        "source": source,
        "sizes": sizes,
        "colors": colors,
        "status": status,
        "description": description,
        "fullDescription": fullDescription,
        "features": features,
        "price": price,
        "vendorPrice": vendorPrice,
        "shippingFees": shippingFees,
        "serviceCharge": serviceCharge,
        "serviceChargeMode": serviceChargeMode,
        "serviceChargeType": serviceChargeType,
        "ratings": ratings,
        "reviews": reviews,
        "stock": stock,
        "images": images,
        "thumbnail": thumbnail,
        "remark": remark,
        "lastModifiedDate": lastModifiedDate,
        "createdDate": createdDate,
    };
}

