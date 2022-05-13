import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:hormoniousflo/data/models/api_response.dart';
import 'package:http/http.dart';

/// A class that handles all the http requests to the server
class Api {
  static const String _baseUrl = 'https://c518-129-18-209-14.ngrok.io/api';

  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<ApiResponse> postData(String url, body,
      {bool hasHeader = false}) async {
    try {
      var request = Request(
        'POST',
        Uri.parse(_baseUrl + url),
      );

      return await _sendRequest(
        request,
        hasHeader,
        body: body,
      );
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException {
      return ApiResponse.timout();
    }
  }

  Future<ApiResponse> _sendRequest(request, bool hasHeader,
      {Map<String, String>? body}) async {
    if (body != null) {
      request.body = json.encode(body);
    }

    if (hasHeader) {
      request.headers.addAll(headers);
    }

    StreamedResponse response = await request.send().timeout(
          const Duration(seconds: 15),
        );

    return await _response(response);
  }

  Future<ApiResponse> getData(String url, {bool hasHeader = false}) async {
    try {
      var request = Request(
        'GET',
        Uri.parse(_baseUrl + url),
      );

      return await _sendRequest(request, hasHeader);
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException {
      return ApiResponse.timout();
    }
  }
}

Future<ApiResponse> _response(StreamedResponse response) async {
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(
        json.decode(await response.stream.bytesToString()));
  } else if (response.statusCode >= 400 && response.statusCode <= 499) {
    return ApiResponse(
      isSuccessful: false,
      message: json.decode(await response.stream.bytesToString())['message'],
    );
  } else if (response.statusCode >= 500 && response.statusCode <= 599) {
    return ApiResponse(
      isSuccessful: false,
      message: 'Error occured while Communication with Server',
    );
  } else {
    return ApiResponse(
      isSuccessful: false,
      message: 'Something went wrong',
    );
  }
}
