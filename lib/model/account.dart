
// ignore_for_file: unnecessary_new

import 'dart:convert';

List<Account> accountFromJson(String str) {
  final jsonData = json.decode(str);
  final list = jsonData["accounts"] as List;
  return list.map((x) => Account.fromJson(x)).toList();
}

class Account {
  int id;
  String code;
  String name;
  String category;
  String type;
  String description;
  int isActive;
  String createdAt;
  String updatedAt;
  int balance;

  Account({
    this.id,
    this.code,
    this.name,
    this.category,
    this.type,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.balance = 0,
  });

  factory Account.fromJson(Map<String, dynamic> json) => new Account(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        category: json['category'],
        type: json['type'],
        description: json['description'],
        isActive: json['is_active'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        balance: json['balance'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'category': category,
        'type': type,
        'description': description,
        'is_active': isActive,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'balance': balance,
      };
}