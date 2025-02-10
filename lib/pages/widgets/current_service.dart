import 'package:csn_tv_display/controller/serving_ticket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:widget_marquee/widget_marquee.dart';

class CurrentServing extends ConsumerStatefulWidget {
  const CurrentServing({
    super.key,
  });

  @override
  ConsumerState<CurrentServing> createState() => _CurrentServingState();
}

class _CurrentServingState extends ConsumerState<CurrentServing> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(servingTicketProvider.notifier).servingTicket();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE60202),
      width: double.infinity,
      padding: const EdgeInsets.all(24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Current serving",
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Gap(24.h),
          ref.watch(servingTicketProvider).when(data: (list) {
            return Marquee(
              delay: const Duration(milliseconds: 500),
              pause: const Duration(seconds: 1),
              duration: const Duration(seconds: 30),
              gap: 0.0.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  list.length,
                  (index) {
                    return list.isEmpty
                        ? Container(
                            height: 195.h,
                          )
                        : Container(
                            margin: const EdgeInsets.only(right: 12).r,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              // borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(24).r,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffD6141B),
                                    // borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    list[index].token.toString(),
                                    style: TextStyle(
                                      fontSize: 56.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 3.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16).r,
                                  child: Text(
                                    "Counter: 1",
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ),
            );
          }, error: (error, stackTrace) {
            return Center(
              child: Text(
                "Error: $error",
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ],
      ),
    );
  }
}
