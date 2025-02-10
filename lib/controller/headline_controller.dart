import 'package:csn_tv_display/service/app_repository_Imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'headline_controller.g.dart';

@riverpod
class Headline extends _$Headline {
  @override
  FutureOr<String> build() {
    return ref.read(appRepositoryImpProvider).headline().then((res) {
      if (res.statusCode == 200) {
        return res.data['data']['notice'];
      }
      return '';
    });
  }
}
