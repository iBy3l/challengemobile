import 'dart:convert';

import 'package:challengemobile/models/content_model.dart';
import 'package:flutter/services.dart';

import 'content_service.dart';

class ContentServiceImpl extends ContentService {
  final content = ContentModel;

  @override
  Future<ContentModel> getContent() async {
    final String response = await rootBundle.loadString(
      'assets/content.json',
    );
    Map<String, dynamic> map = json.decode(response);
    // print("mosntrar pdf ${map['pdf']} ");

    return ContentModel.fromMap(map);
  }
}
