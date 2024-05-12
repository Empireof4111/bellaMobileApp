// ignore_for_file: file_names

import 'dart:convert';

class VendorModel {
    final int? id;
    final String? role;
    final String? uuid;
    final String? name;
    final String? businessName;
    final String? businessEmail;
    final String? businessMobile;
    final String? businessAddress;
    final String? businessCacLink;
    final String? businessNepcLink;
    final String? description;
    final String? handle;
    final String? idType;
    final String? idLink;
    final String? personalEmail;
    final String? email;
    final dynamic isVerified;
    final dynamic isSubscribed;
    final bool? isEnabled;
    final dynamic gender;
    final int? kycLevel;
    final dynamic categoryId;
    final String? accountType;
    final String? mobile;
    final dynamic preferredCurrency;
    final String? password;
    final String? status;
    final dynamic address;
    final String? country;
    final String? city;
    final dynamic dpLink;
    final dynamic thirdPartyToken;
    final String? authProvider;
    final dynamic location;
    final dynamic newsLetter;
    final int? lastLoginDate;
    final int? lastModifiedDate;
    final int? createdDate;

    VendorModel({
        this.id,
        this.role,
        this.uuid,
        this.name,
        this.businessName,
        this.businessEmail,
        this.businessMobile,
        this.businessAddress,
        this.businessCacLink,
        this.businessNepcLink,
        this.description,
        this.handle,
        this.idType,
        this.idLink,
        this.personalEmail,
        this.email,
        this.isVerified,
        this.isSubscribed,
        this.isEnabled,
        this.gender,
        this.kycLevel,
        this.categoryId,
        this.accountType,
        this.mobile,
        this.preferredCurrency,
        this.password,
        this.status,
        this.address,
        this.country,
        this.city,
        this.dpLink,
        this.thirdPartyToken,
        this.authProvider,
        this.location,
        this.newsLetter,
        this.lastLoginDate,
        this.lastModifiedDate,
        this.createdDate,
    });

    VendorModel copyWith({
        int? id,
        String? role,
        String? uuid,
        String? name,
        String? businessName,
        String? businessEmail,
        String? businessMobile,
        String? businessAddress,
        String? businessCacLink,
        String? businessNepcLink,
        String? description,
        String? handle,
        String? idType,
        String? idLink,
        String? personalEmail,
        String? email,
        dynamic isVerified,
        dynamic isSubscribed,
        bool? isEnabled,
        dynamic gender,
        int? kycLevel,
        dynamic categoryId,
        String? accountType,
        String? mobile,
        dynamic preferredCurrency,
        String? password,
        String? status,
        dynamic address,
        String? country,
        String? city,
        dynamic dpLink,
        dynamic thirdPartyToken,
        String? authProvider,
        dynamic location,
        dynamic newsLetter,
        int? lastLoginDate,
        int? lastModifiedDate,
        int? createdDate,
    }) => 
        VendorModel(
            id: id ?? this.id,
            role: role ?? this.role,
            uuid: uuid ?? this.uuid,
            name: name ?? this.name,
            businessName: businessName ?? this.businessName,
            businessEmail: businessEmail ?? this.businessEmail,
            businessMobile: businessMobile ?? this.businessMobile,
            businessAddress: businessAddress ?? this.businessAddress,
            businessCacLink: businessCacLink ?? this.businessCacLink,
            businessNepcLink: businessNepcLink ?? this.businessNepcLink,
            description: description ?? this.description,
            handle: handle ?? this.handle,
            idType: idType ?? this.idType,
            idLink: idLink ?? this.idLink,
            personalEmail: personalEmail ?? this.personalEmail,
            email: email ?? this.email,
            isVerified: isVerified ?? this.isVerified,
            isSubscribed: isSubscribed ?? this.isSubscribed,
            isEnabled: isEnabled ?? this.isEnabled,
            gender: gender ?? this.gender,
            kycLevel: kycLevel ?? this.kycLevel,
            categoryId: categoryId ?? this.categoryId,
            accountType: accountType ?? this.accountType,
            mobile: mobile ?? this.mobile,
            preferredCurrency: preferredCurrency ?? this.preferredCurrency,
            password: password ?? this.password,
            status: status ?? this.status,
            address: address ?? this.address,
            country: country ?? this.country,
            city: city ?? this.city,
            dpLink: dpLink ?? this.dpLink,
            thirdPartyToken: thirdPartyToken ?? this.thirdPartyToken,
            authProvider: authProvider ?? this.authProvider,
            location: location ?? this.location,
            newsLetter: newsLetter ?? this.newsLetter,
            lastLoginDate: lastLoginDate ?? this.lastLoginDate,
            lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
            createdDate: createdDate ?? this.createdDate,
        );

    factory VendorModel.fromJson(String str) => VendorModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory VendorModel.fromMap(Map<String, dynamic> json) => VendorModel(
        id: json["id"],
        role: json["role"],
        uuid: json["uuid"],
        name: json["name"],
        businessName: json["businessName"],
        businessEmail: json["businessEmail"],
        businessMobile: json["businessMobile"],
        businessAddress: json["businessAddress"],
        businessCacLink: json["businessCACLink"],
        businessNepcLink: json["businessNEPCLink"],
        description: json["description"],
        handle: json["handle"],
        idType: json["idType"],
        idLink: json["idLink"],
        personalEmail: json["personalEmail"],
        email: json["email"],
        isVerified: json["isVerified"],
        isSubscribed: json["isSubscribed"],
        isEnabled: json["isEnabled"],
        gender: json["gender"],
        kycLevel: json["kycLevel"],
        categoryId: json["categoryId"],
        accountType: json["accountType"],
        mobile: json["mobile"],
        preferredCurrency: json["preferredCurrency"],
        password: json["password"],
        status: json["status"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        dpLink: json["dpLink"],
        thirdPartyToken: json["thirdPartyToken"],
        authProvider: json["authProvider"],
        location: json["location"],
        newsLetter: json["newsLetter"],
        lastLoginDate: json["lastLoginDate"],
        lastModifiedDate: json["lastModifiedDate"],
        createdDate: json["createdDate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "role": role,
        "uuid": uuid,
        "name": name,
        "businessName": businessName,
        "businessEmail": businessEmail,
        "businessMobile": businessMobile,
        "businessAddress": businessAddress,
        "businessCACLink": businessCacLink,
        "businessNEPCLink": businessNepcLink,
        "description": description,
        "handle": handle,
        "idType": idType,
        "idLink": idLink,
        "personalEmail": personalEmail,
        "email": email,
        "isVerified": isVerified,
        "isSubscribed": isSubscribed,
        "isEnabled": isEnabled,
        "gender": gender,
        "kycLevel": kycLevel,
        "categoryId": categoryId,
        "accountType": accountType,
        "mobile": mobile,
        "preferredCurrency": preferredCurrency,
        "password": password,
        "status": status,
        "address": address,
        "country": country,
        "city": city,
        "dpLink": dpLink,
        "thirdPartyToken": thirdPartyToken,
        "authProvider": authProvider,
        "location": location,
        "newsLetter": newsLetter,
        "lastLoginDate": lastLoginDate,
        "lastModifiedDate": lastModifiedDate,
        "createdDate": createdDate,
    };
}
