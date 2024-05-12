// ignore_for_file: file_names

import 'dart:convert';

class OrderDetailModel {
    final Details? details;
    final Product? product;

    OrderDetailModel({
        this.details,
        this.product,
    });

    OrderDetailModel copyWith({
        Details? details,
        Product? product,
    }) => 
        OrderDetailModel(
            details: details ?? this.details,
            product: product ?? this.product,
        );

    factory OrderDetailModel.fromJson(String str) => OrderDetailModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderDetailModel.fromMap(Map<String, dynamic> json) => OrderDetailModel(
        details: json["details"] == null ? null : Details.fromMap(json["details"]),
        product: json["product"] == null ? null : Product.fromMap(json["product"]),
    );

    Map<String, dynamic> toMap() => {
        "details": details?.toMap(),
        "product": product?.toMap(),
    };
}

class Details {
    final int? id;
    final int? orderId;
    final int? vendorId;
    final int? customerId;
    final String? vendorName;
    final String? vendorTelephone;
    final dynamic vendorEmailAddress;
    final String? vendorAddress;
    final int? productId;
    final String? productName;
    final int? quantity;
    final dynamic color;
    final dynamic size;
    final String? status;
    final double? price;
    final double? amount;
    final double? systemCharges;
    final double? vendorPayableAmount;
    final double? shippingFees;
    final String? transactionCurrency;
    final int? lastModifiedDate;
    final int? createdDate;

    Details({
        this.id,
        this.orderId,
        this.vendorId,
        this.customerId,
        this.vendorName,
        this.vendorTelephone,
        this.vendorEmailAddress,
        this.vendorAddress,
        this.productId,
        this.productName,
        this.quantity,
        this.color,
        this.size,
        this.status,
        this.price,
        this.amount,
        this.systemCharges,
        this.vendorPayableAmount,
        this.shippingFees,
        this.transactionCurrency,
        this.lastModifiedDate,
        this.createdDate,
    });

    Details copyWith({
        int? id,
        int? orderId,
        int? vendorId,
        int? customerId,
        String? vendorName,
        String? vendorTelephone,
        dynamic vendorEmailAddress,
        String? vendorAddress,
        int? productId,
        String? productName,
        int? quantity,
        dynamic color,
        dynamic size,
        String? status,
        double? price,
        double? amount,
        double? systemCharges,
        double? vendorPayableAmount,
        double? shippingFees,
        String? transactionCurrency,
        int? lastModifiedDate,
        int? createdDate,
    }) => 
        Details(
            id: id ?? this.id,
            orderId: orderId ?? this.orderId,
            vendorId: vendorId ?? this.vendorId,
            customerId: customerId ?? this.customerId,
            vendorName: vendorName ?? this.vendorName,
            vendorTelephone: vendorTelephone ?? this.vendorTelephone,
            vendorEmailAddress: vendorEmailAddress ?? this.vendorEmailAddress,
            vendorAddress: vendorAddress ?? this.vendorAddress,
            productId: productId ?? this.productId,
            productName: productName ?? this.productName,
            quantity: quantity ?? this.quantity,
            color: color ?? this.color,
            size: size ?? this.size,
            status: status ?? this.status,
            price: price ?? this.price,
            amount: amount ?? this.amount,
            systemCharges: systemCharges ?? this.systemCharges,
            vendorPayableAmount: vendorPayableAmount ?? this.vendorPayableAmount,
            shippingFees: shippingFees ?? this.shippingFees,
            transactionCurrency: transactionCurrency ?? this.transactionCurrency,
            lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
            createdDate: createdDate ?? this.createdDate,
        );

    factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Details.fromMap(Map<String, dynamic> json) => Details(
        id: json["id"],
        orderId: json["orderId"],
        vendorId: json["vendorId"],
        customerId: json["customerId"],
        vendorName: json["vendorName"],
        vendorTelephone: json["vendorTelephone"],
        vendorEmailAddress: json["vendorEmailAddress"],
        vendorAddress: json["vendorAddress"],
        productId: json["productId"],
        productName: json["productName"],
        quantity: json["quantity"],
        color: json["color"],
        size: json["size"],
        status: json["status"],
        price: json["price"],
        amount: json["amount"]?.toDouble(),
        systemCharges: json["systemCharges"],
        vendorPayableAmount: json["vendorPayableAmount"]?.toDouble(),
        shippingFees: json["shippingFees"]?.toDouble(),
        transactionCurrency: json["transactionCurrency"],
        lastModifiedDate: json["lastModifiedDate"],
        createdDate: json["createdDate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "orderId": orderId,
        "vendorId": vendorId,
        "customerId": customerId,
        "vendorName": vendorName,
        "vendorTelephone": vendorTelephone,
        "vendorEmailAddress": vendorEmailAddress,
        "vendorAddress": vendorAddress,
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "color": color,
        "size": size,
        "status": status,
        "price": price,
        "amount": amount,
        "systemCharges": systemCharges,
        "vendorPayableAmount": vendorPayableAmount,
        "shippingFees": shippingFees,
        "transactionCurrency": transactionCurrency,
        "lastModifiedDate": lastModifiedDate,
        "createdDate": createdDate,
    };
}

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
            vendorPrice: vendorPrice ?? this.vendorPrice,
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
