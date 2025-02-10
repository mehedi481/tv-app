import 'package:csn_tv_display/config/app_constants.dart';
import 'package:csn_tv_display/service/app_repository_Imp.dart';
import 'package:csn_tv_display/service/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class Login extends _$Login {
  @override
  bool build() {
    return false;
  }

  Future<bool> login({required String token}) {
    state = true;
    return ref
        .read(appRepositoryImpProvider)
        .login(token: token, type: "TV")
        .then((res) {
      if (res.statusCode == 200) {
        Hive.box(AppConstants.authBox)
            .put(AppConstants.authToken, res.data['data']['token']);
        return true;
      }
      return false;
    }).catchError((e) {
      return false;
    }).whenComplete(() {
      state = false;
    });
  }
}

@Riverpod(keepAlive: false)
class AddIdentifier extends _$AddIdentifier {
  @override
  void build() {
    createIndentity();
  }

  createIndentity() async {
    await ref.read(appRepositoryImpProvider).addIdentifier().then((res) {
      if (res.statusCode == 200) {
        SocketService().conntectToSocket(
            indentity: res.data['data']['identifier'].toString());
      }
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }
}
