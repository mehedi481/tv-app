import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:csn_tv_display/controller/promotional_banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromotionalSection extends ConsumerWidget {
  const PromotionalSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        color: const Color(0xffF1F1F1),
        alignment: Alignment.center,
        child: ref.watch(promotionalBannerProvider).when(data: (bannerList) {
          return CarouselSlider(
            items: bannerList.map((item) {
              return CachedNetworkImage(
                imageUrl: item.image ?? '',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
              height: double.infinity,
              // aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          );
        }, error: (error, stackTrace) {
          return const Text('Error');
        }, loading: () {
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
