import '../models/content_model.dart';

abstract class ContentService {
  Future<ContentModel> getContent();
}
