// this is a model for holding Api responses.

class ApiResponseModel {
  final int statusCode; // HTTP status code of the response
  final dynamic data; // data from the respones(can be null)

  ApiResponseModel({required this.statusCode, this.data});
}
