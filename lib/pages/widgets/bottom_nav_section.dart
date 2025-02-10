import 'package:csn_tv_display/controller/headline_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

class BottomNavSection extends ConsumerWidget {
  const BottomNavSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 108.h,
      width: double.infinity,
      color: const Color(0xffE60202),
      child: ref.watch(headlineProvider).when(data: (txt) {
        return Marquee(
          text: txt,
          blankSpace: 100.0,
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.sp,
            fontWeight: FontWeight.w700,
          ),
        );
      }, error: (error, stack) {
        return Center(
          child: Text(
            'Error: $error',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }, loading: () {
        return const Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }),
    );
  }
}
