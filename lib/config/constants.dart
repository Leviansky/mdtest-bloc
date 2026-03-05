// ignore_for_file: constant_identifier_names

part 'server.dart';

const int STATUS_OK = 200;
const int STATUS_CREATED_OK = 201;
const int STATUS_NO_CONTENT = 204;
const int STATUS_BAD_REQUEST = 400;
const int STATUS_UNAUTHORIZED = 401;
const int STATUS_NOT_AUTHORIZED = 403;
const int STATUS_NOT_FOUND = 404;
const int STATUS_INTERNAL_ERROR = 500;
const int STATUS_SERVICE_UNAVAILABLE = 503;

const String PRODUCTION_BASE_URL = '';
const String PRODUCTION_IMAGE_URL = "";

bool isDevelopment() => true;
