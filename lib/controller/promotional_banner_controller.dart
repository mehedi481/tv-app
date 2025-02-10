import 'package:csn_tv_display/models/banner_model.dart';
import 'package:csn_tv_display/service/app_repository_Imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promotional_banner_controller.g.dart';

@riverpod
class PromotionalBanner extends _$PromotionalBanner {
  @override
  FutureOr<List<BannerModel>> build() {
    return ref.read(appRepositoryImpProvider).promotionalBanner().then((res) {
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['sliders'];
        return data.map((e) => BannerModel.fromMap(e)).toList();
      }
      return [];
    });
  }
}
