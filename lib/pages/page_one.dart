import 'package:csn_tv_display/controller/auth_controller.dart';
import 'package:csn_tv_display/controller/providers.dart';
import 'package:csn_tv_display/pages/widgets/bottom_nav_section.dart';
import 'package:csn_tv_display/pages/widgets/current_service.dart';
import 'package:csn_tv_display/pages/widgets/promotional_section.dart';
import 'package:csn_tv_display/pages/widgets/queue_section.dart';
import 'package:csn_tv_display/service/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class PageOne extends ConsumerStatefulWidget {
  const PageOne({super.key});

  @override
  ConsumerState<PageOne> createState() => _PageOneState();
}

class _PageOneState extends ConsumerState<PageOne> {
  static const eventChannel = EventChannel('screen_state/events');

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(
      (dynamic isScreenOn) {
        if (isScreenOn) {
          SocketService().disConnect();
          ref.read(addIdentifierProvider);
        } else {
          SocketService().disConnect();
        }
      },
      onError: (dynamic error) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    // hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const _AppBar(),
                          const CurrentServing(),
                          Gap(32.w),
                          const PromotionalSection(),
                          Gap(32.w),
                        ],
                      ),
                    ),
                  ),
                  Gap(32.w),
                  Expanded(
                    child: Container(
                      color: const Color(0xff1F7697),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.black.withOpacity(0.5),
                            height: 108.h,
                            width: double.infinity,
                            child: const _QuequAppBar(),
                          ),
                          const Expanded(child: QuequSection()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const BottomNavSection(),
          ],
        ),
      ),
    );
  }
}

class _QuequAppBar extends ConsumerWidget {
  const _QuequAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(dateTimeProvider).when(
          data: (dateTime) {
            final timeText = DateFormat('hh:mm a').format(dateTime);
            final dateText = DateFormat('dd MMM, yyyy').format(dateTime);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeText,
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Gap(30.w),
                const VerticalDivider(indent: 25, endIndent: 25),
                Gap(30.w),
                Text(
                  dateText,
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
              child: Text('Loading...', style: TextStyle(color: Colors.white))),
          error: (_, __) => const Text('Error'),
        );
  }
}

class _AppBar extends ConsumerWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 108.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20).r,
      child: SvgPicture.asset(
        "assets/svgs/logo.svg",
        height: 64.h,
      ),
    );
  }
}
