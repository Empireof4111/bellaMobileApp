// ignore_for_file: file_names

import 'dart:convert';

class CategoryModel {
    final Category? category;
    final List<SubCategory>? subCategories;

    CategoryModel({
        this.category,
        this.subCategories,
    });

    CategoryModel copyWith({
        Category? category,
        List<SubCategory>? subCategories,
    }) => 
        CategoryModel(
            category: category ?? this.category,
            subCategories: subCategories ?? this.subCategories,
        );

    factory CategoryModel.fromJson(String str) => CategoryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        category: json["category"] == null ? null : Category.fromMap(json["category"]),
        subCategories: json["subCategories"] == null ? [] : List<SubCategory>.from(json["subCategories"]!.map((x) => SubCategory.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "category": category?.toMap(),
        "subCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toMap())),
    };
}

class Category {
    final int? id;
    final String? type;
    final String? name;
    final String? imageLink;
    final int? createdDate;

    Category({
        this.id,
        this.type,
        this.name,
        this.imageLink,
        this.createdDate,
    });

    Category copyWith({
        int? id,
        String? type,
        String? name,
        String? imageLink,
        int? createdDate,
    }) => 
        Category(
            id: id ?? this.id,
            type: type ?? this.type,
            name: name ?? this.name,
            imageLink: imageLink ?? this.imageLink,
            createdDate: createdDate ?? this.createdDate,
        );

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        imageLink: json["imageLink"],
        createdDate: json["createdDate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "imageLink": imageLink,
        "createdDate": createdDate,
    };
}

class SubCategory {
    final int? id;
    final int? categoryId;
    final String? name;
    final int? createdDate;

    SubCategory({
        this.id,
        this.categoryId,
        this.name,
        this.createdDate,
    });

    SubCategory copyWith({
        int? id,
        int? categoryId,
        String? name,
        int? createdDate,
    }) => 
        SubCategory(
            id: id ?? this.id,
            categoryId: categoryId ?? this.categoryId,
            name: name ?? this.name,
            createdDate: createdDate ?? this.createdDate,
        );

    factory SubCategory.fromJson(String str) => SubCategory.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
        createdDate: json["createdDate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "createdDate": createdDate,
    };
}
