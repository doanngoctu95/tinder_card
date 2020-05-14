import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/user.dart';

class Repository {
  /// get user from asset
  Future<User> generateListUsers(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data");
    print('data: $data');
    final jsonParse = json.decode(data);
    User user = User();
    if (jsonParse != null) {
      user = User.fromJsonMap(jsonParse);
    }
    return user;
  }
}
