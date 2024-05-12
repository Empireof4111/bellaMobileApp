// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:convert';

class User {
    late final int? id;
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
  User({
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
    required this.isVerified,
    required this.isSubscribed,
    this.isEnabled,
    required this.gender,
    this.kycLevel,
    required this.categoryId,
    this.accountType,
    this.mobile,
    required this.preferredCurrency,
    this.password,
    this.status,
    required this.address,
    this.country,
    this.city,
    required this.dpLink,
    required this.thirdPartyToken,
    this.authProvider,
    required this.location,
    required this.newsLetter,
    this.lastLoginDate,
    this.lastModifiedDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role,
      'uuid': uuid,
      'name': name,
      'businessName': businessName,
      'businessEmail': businessEmail,
      'businessMobile': businessMobile,
      'businessAddress': businessAddress,
      'businessCacLink': businessCacLink,
      'businessNepcLink': businessNepcLink,
      'description': description,
      'handle': handle,
      'idType': idType,
      'idLink': idLink,
      'personalEmail': personalEmail,
      'email': email,
      'isVerified': isVerified,
      'isSubscribed': isSubscribed,
      'isEnabled': isEnabled,
      'gender': gender,
      'kycLevel': kycLevel,
      'categoryId': categoryId,
      'accountType': accountType,
      'mobile': mobile,
      'preferredCurrency': preferredCurrency,
      'password': password,
      'status': status,
      'address': address,
      'country': country,
      'city': city,
      'dpLink': dpLink,
      'thirdPartyToken': thirdPartyToken,
      'authProvider': authProvider,
      'location': location,
      'newsLetter': newsLetter,
      'lastLoginDate': lastLoginDate,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      role: map['role'] != null ? map['role'] as String : null,
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      businessName: map['businessName'] != null ? map['businessName'] as String : null,
      businessEmail: map['businessEmail'] != null ? map['businessEmail'] as String : null,
      businessMobile: map['businessMobile'] != null ? map['businessMobile'] as String : null,
      businessAddress: map['businessAddress'] != null ? map['businessAddress'] as String : null,
      businessCacLink: map['businessCacLink'] != null ? map['businessCacLink'] as String : null,
      businessNepcLink: map['businessNepcLink'] != null ? map['businessNepcLink'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      handle: map['handle'] != null ? map['handle'] as String : null,
      idType: map['idType'] != null ? map['idType'] as String : null,
      idLink: map['idLink'] != null ? map['idLink'] as String : null,
      personalEmail: map['personalEmail'] != null ? map['personalEmail'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      isVerified: map['isVerified'] as dynamic,
      isSubscribed: map['isSubscribed'] as dynamic,
      isEnabled: map['isEnabled'] != null ? map['isEnabled'] as bool : null,
      gender: map['gender'] as dynamic,
      kycLevel: map['kycLevel'] != null ? map['kycLevel'] as int : null,
      categoryId: map['categoryId'] as dynamic,
      accountType: map['accountType'] != null ? map['accountType'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      preferredCurrency: map['preferredCurrency'] as dynamic,
      password: map['password'] != null ? map['password'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      address: map['address'] as dynamic,
      country: map['country'] != null ? map['country'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      dpLink: map['dpLink'] as dynamic,
      thirdPartyToken: map['thirdPartyToken'] as dynamic,
      authProvider: map['authProvider'] != null ? map['authProvider'] as String : null,
      location: map['location'] as dynamic,
      newsLetter: map['newsLetter'] as dynamic,
      lastLoginDate: map['lastLoginDate'] != null ? map['lastLoginDate'] as int : null,
      lastModifiedDate: map['lastModifiedDate'] != null ? map['lastModifiedDate'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}

