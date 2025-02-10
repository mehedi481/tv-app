import 'package:dio/dio.dart';

abstract class AppRepository {
  Future<Response> login({required String token, required String type});
  Future<Response> servingTicket();
  Future<Response> queueTicket();
  Future<Response> headline();
  Future<Response> promotionalBanner();
  Future<Response> addIdentifier();
}
