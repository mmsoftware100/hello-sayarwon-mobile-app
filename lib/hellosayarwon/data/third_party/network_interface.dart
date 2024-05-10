import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';



abstract class NetworkInterface {

  Future<dynamic> getRequest({required String url, required Map<String,dynamic> data,String? bearerToken});

  Future<dynamic> postRequest({required String url, required Map<String,dynamic> data, String? bearerToken});

  Future<dynamic> putRequest({required String url, required String id, required Map<String,dynamic> data, String? bearerToken});

  Future<dynamic> deleteRequest({required String url, required int id, String? bearerToken});

}


class NetworkInterfaceImpl implements NetworkInterface{
  final Dio client;

  NetworkInterfaceImpl({
    required this.client
  });

  @override
  Future<dynamic> deleteRequest({required String url, required int id, String? bearerToken}) async {
    // TODO: implement deleteRequest
    try{
      String endPoint = "$url/$id";
      Map<String,dynamic> data = {};

      if(bearerToken != null){
        client.options.headers["Authorization"] = "Bearer $bearerToken";
      }

      Response<dynamic> response = await client.delete(endPoint);
      data = response.data;
      return data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
        rethrow;
      }
      print(exp);
      throw ServerException();
    }
  }

  @override
  Future<dynamic> getRequest({required String url, required Map<String, dynamic> data, String? bearerToken})async {
    List<String> keyValuePairs = [];
    data.forEach((key, value) {
      if (value != null) {
        if (value is List) {
          for (var item in value) {
            keyValuePairs.add('$key=${Uri.encodeQueryComponent('$item')}');
          }
        } else {
          keyValuePairs.add('$key=${Uri.encodeQueryComponent('$value')}');
        }
      }
    });

    String query =  keyValuePairs.join('&');

    try{
      String endPoint = url+ "?" + query;

      print(endPoint);

      if(bearerToken != null){
        client.options.headers["Authorization"] = "Bearer $bearerToken";
      }
      Response<dynamic> response = await client.get(endPoint);
      return response.data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
        rethrow;
      }
      print(exp);
      throw ServerException();
    }
  }

  @override
  Future<dynamic> postRequest({required String url, required Map<String, dynamic> data, String? bearerToken}) async {
    // TODO: implement postRequest
    try{
      String endPoint = url;
      if(bearerToken != null){
        client.options.headers["Authorization"] = "Bearer $bearerToken";
      }
      client.options.headers["Accept"] = "application/json";
      Response<dynamic> response = await client.post(endPoint, data: data);
      return response.data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
        rethrow;
      }
      print(exp);
      throw ServerException();
    }
  }

  @override
  Future<dynamic> putRequest({required String url, required String id, required Map<String, dynamic> data, String? bearerToken}) async {
    // TODO: implement putRequest
    try{
      String endPoint = url +  (id.isEmpty ? "" : "/$id");
      if(bearerToken != null){
        client.options.headers["Authorization"] = "Bearer $bearerToken";
      }
      Response<dynamic> response = await client.put(endPoint, data: data);
      return response.data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
        rethrow;
      }
      print(exp);
      throw ServerException();
    }
  }


}