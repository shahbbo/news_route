import '../../../../core/api/api_manager.dart';
import '../model/news_response.dart';
class NewsRepository {
  final ApiManager apiManager;
  NewsRepository({required this.apiManager});
  Future<List<News>> getNewsByPagination(String sourceId, int pageKey) async {
    final response = await ApiManager.getNewsByPaganition(sourceId, pageKey);
    return response.articles ?? [];
  }
}
