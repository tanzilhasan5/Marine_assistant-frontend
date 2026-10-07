import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

import '../error_model/error_response.dart';
import '../helpers/prefs_helpers.dart';
import '../utils/app_constants.dart';
import 'api_constant.dart';

class ApiClient extends GetxService {
  static var client = http.Client();

  static const String noInternetMessage =
      "Sorry! Time out please try again";
  static const int timeoutInSeconds = 60;

  static String bearerToken = "";

  static final Map<String, Future<Response>> _inFlightGetRequests = {};

  static Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async
  {
    bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    final parsedUri = Uri.parse(ApiConstant.baseUrl + uri);
    final queryParams = Map<String, String>.from(parsedUri.queryParameters);
    if (query != null) {
      query.forEach((key, value) {
        queryParams[key] = value.toString();
      });
    }
    // Only generate _t if it wasn't already in the URI query params
    if (!queryParams.containsKey('_t')) {
      final now = DateTime.now().millisecondsSinceEpoch;
      // Round to nearest 1000ms to allow concurrent requests within 1s to deduplicate
      final roundedTime = (now ~/ 1000) * 1000;
      queryParams['_t'] = roundedTime.toString();
    }
    final cleanUri = parsedUri.replace(queryParameters: queryParams);
    final requestKey = cleanUri.toString();

    if (_inFlightGetRequests.containsKey(requestKey)) {
      debugPrint('====> API GET Request Deduplication: Reusing in-flight request for: $requestKey');
      return _inFlightGetRequests[requestKey]!;
    }

    final future = () async {
      try {
        print('====> API Call: $cleanUri\nHeader: ${headers ?? mainHeaders}');

        http.Response response = await client
            .get(
              cleanUri,
              headers: headers ?? mainHeaders,
            )
            .timeout(const Duration(seconds: timeoutInSeconds));
        return handleResponse(response, uri);
      } catch (e) {
        print('------------${e.toString()}');
        return const Response(statusCode: 1, statusText: noInternetMessage);
      }
    }();

    _inFlightGetRequests[requestKey] = future;
    future.whenComplete(() {
      _inFlightGetRequests.remove(requestKey);
    });

    return future;
  }

  static Future<Response> postData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
    int? timeoutInSeconds,
  }) async
  {
    bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      if (bearerToken.isNotEmpty) 'Authorization': 'Bearer $bearerToken',
    };
    final combinedHeaders = {...mainHeaders, ...?headers};

    try {
      debugPrint('=====> API Call: $uri\nHeader: $combinedHeaders');
      debugPrint('=====> API Body: $body');

      http.Response response = await client
          .post(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: body is String ? body : jsonEncode(body),
            headers: combinedHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds ?? ApiClient.timeoutInSeconds));
      debugPrint(
        "==========> Response Post Method :------ : ${response.statusCode}",
      );
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> API Client postData Error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> postMultipartData(
      String uri,
      Map<String, String> body, {
        required List<MultipartBody> multipartBody,
        Map<String, String>? headers,
        int? timeoutInSeconds,
      })
  async {
    try {
      bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} file(s)');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstant.baseUrl + uri),
      );

      request.headers.addAll(headers ?? mainHeaders);

      for (MultipartBody element in multipartBody) {
        if (element.file != null && element.file!.path.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(
              element.key,
              element.file!.path,
            ),
          );
        }
      }

      request.fields.addAll(body);

      final streamedResponse = await request.send().timeout(
        Duration(
          seconds: timeoutInSeconds ?? ApiClient.timeoutInSeconds,
        ),
      );

      http.Response response = await http.Response.fromStream(streamedResponse);

      debugPrint('====> Response [${response.statusCode}]: ${response.body}');

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> API Error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .put(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: body is String ? body : jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> patchData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .patch(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: body is String ? body : jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> putMultipartData(
    String uri,
    Map<String, String> body, {
    required List<MultipartBody> multipartBody,
    Map<String, String>? headers,
  }) async {
    try {
      bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} file(s)');

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiConstant.baseUrl + uri),
      );

      request.headers.addAll(headers ?? mainHeaders);

      for (MultipartBody element in multipartBody) {
        if (element.file != null && element.file!.path.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(element.key, element.file!.path),
          );
        }
      }

      request.fields.addAll(body);

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: timeoutInSeconds),
      );

      http.Response response = await http.Response.fromStream(streamedResponse);

      debugPrint('====> Response [${response.statusCode}]: ${response.body}');

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> API Error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> patchMultipartData(
    String uri,
    Map<String, String> body, {
    required List<MultipartBody> multipartBody,
    Map<String, String>? headers,
  }) async {
    try {
      bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} file(s)');

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiConstant.baseUrl + uri),
      );

      request.headers.addAll(headers ?? mainHeaders);

      for (MultipartBody element in multipartBody) {
        if (element.file != null && element.file!.path.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(element.key, element.file!.path),
          );
        }
      }

      request.fields.addAll(body);

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: timeoutInSeconds),
      );

      http.Response response = await http.Response.fromStream(streamedResponse);

      debugPrint('====> Response [${response.statusCode}]: ${response.body}');

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> API Error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> deleteData(
    String uri, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    bearerToken = PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
      'ngrok-skip-browser-warning': 'true',
    };

    try {
      debugPrint('====> DELETE Call: ${ApiConstant.baseUrl + uri}');

      http.Response response = await http
          .delete(
            Uri.parse(ApiConstant.baseUrl + uri),
            headers: headers ?? mainHeaders,
            body: body,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      debugPrint('====> DELETE Response Status: ${response.statusCode}');

      if (response.statusCode == 204) {
        return Response(statusCode: 204, statusText: 'No Content', body: null);
      }

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> DELETE Error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Response handleResponse(http.Response response, String uri) {
    dynamic body;

    print('=====> RAW Response [${response.statusCode}] $uri: ${response.body}');

    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint('=====> JSON decode error: $e');
    }

    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode != 200 &&
        response0.statusCode != 201 &&
        response0.body != null &&
        response0.body is! String) {
      try {
        ErrorResponse errorResponse = ErrorResponse.fromJson(
          response0.body is Map<String, dynamic>
              ? response0.body
              : Map<String, dynamic>.from(response0.body as Map),
        );
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          bodyString: response0.bodyString,
          headers: response0.headers,
          request: response0.request,
          statusText: errorResponse.message ?? response.reasonPhrase,
        );
      } catch (e) {
        debugPrint('=====> ErrorResponse.fromJson failed: $e');
      }
    } else if (response0.statusCode != 200 &&
        response0.statusCode != 201 &&
        response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    } else if (response0.body is Map && response0.body["success"] == false) {
      try {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          bodyString: response0.bodyString,
          headers: response0.headers,
          request: response0.request,
          statusText: errorResponse.message,
        );
      } catch (e) {
        debugPrint('=====> ErrorResponse.fromJson (success=false) failed: $e');
      }
    }

    debugPrint('=====> API Response: [${response0.statusCode}] $uri');
    return response0;
  }
}

class MultipartBody {
  String key;
  File? file;

  MultipartBody(this.key, this.file);
}
