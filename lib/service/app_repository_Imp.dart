import 'package:csn_tv_display/config/app_constants.dart';
import 'package:csn_tv_display/service/app_repository.dart';
import 'package:csn_tv_display/utils/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_repository_Imp.g.dart';

@riverpod
AppRepositoryImp appRepositoryImp(Ref ref) {
  return AppRepositoryImp(ref: ref);
}

class AppRepositoryImp extends AppRepository {
  AppRepositoryImp({required this.ref});
  final Ref ref;

  @override
  Future<Response> login({required String token, required String type}) {
    return ref.read(apiClientProvider).post(AppConstants.login, data: {
      "token": token,
      "type": type,
    });
  }

  @override
  Future<Response> servingTicket() {
    return ref.read(apiClientProvider).get(AppConstants.servingTicket);
  }

  @override
  Future<Response> queueTicket() {
    return ref.read(apiClientProvider).get(AppConstants.queueTicket);
  }

  @override
  Future<Response> headline() {
    return ref.read(apiClientProvider).get(AppConstants.headline);
  }

  @override
  Future<Response> promotionalBanner() {
    return ref.read(apiClientProvider).get(AppConstants.promotionalBanner);
  }

  @override
  Future<Response> addIdentifier() {
    return ref.read(apiClientProvider).get(AppConstants.addIdentifier);
  }
}
