import 'dart:convert';

import 'package:http/http.dart' as https;

import '../../features/news_view/data/model/news_response.dart';
import '../../features/news_view/data/model/source_response.dart';
import 'api_constants.dart';
import 'end_points.dart';

class ApiManager {

   static Future<SourceResponse?> getSources(String categoryId)async{

     Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi,
       {
         'apiKey' : ApiConstants.apiKey,
         'category' : categoryId,
       });
     try{
       var response = await https.get(url);
       return SourceResponse.fromJson(jsonDecode(response.body));
     }catch (e){
       rethrow;
     }
   }

   //newsapi.org/v2/everything?q=bitcoin&apiKey=dd22b31089204d69afcdba36302a389b
   static Future<NewsResponse> getNewsByPaganition (String sourceId , int pageNumber) async {
     Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,{
       'apiKey' : ApiConstants.apiKey,
       'sources' : sourceId,
       'page' : pageNumber.toString(),
       'pageSize' : '10',
     } );
     try{
       var response = await https.get(url);
       return NewsResponse.fromJson(jsonDecode(response.body));
     }catch (e){
       rethrow;
     }
   }
   static Future<NewsResponse> getNewsBySourceId (String sourceId) async {
     Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,{
       'apiKey' : ApiConstants.apiKey,
       'sources' : sourceId,
     } );
     try{
       var response = await https.get(url);
       return NewsResponse.fromJson(jsonDecode(response.body));
     }catch (e){
       rethrow;
     }
   }

}