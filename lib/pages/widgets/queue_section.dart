import 'package:csn_tv_display/controller/queue_ticket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class QuequSection extends ConsumerStatefulWidget {
  const QuequSection({
    super.key,
  });

  @override
  ConsumerState<QuequSection> createState() => _QuequSectionState();
}

class _QuequSectionState extends ConsumerState<QuequSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(quequTicketProvider.notifier).queueTicket();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: const Color(0xff1F7697),
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      child: ref.watch(quequTicketProvider).when(
            data: (list) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 35, horizontal: 32)
                            .r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Queue in:',
                          style: TextStyle(
                            color: const Color(0xFFF9FF00),
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(48.w),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/user.svg",
                              height: 55.r,
                              width: 55.r,
                            ),
                            Gap(12.w),
                            Text(
                              list.length.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: const Color(0xFFF9FF00),
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(16.h),
                  queueField(
                    context: context,
                    title: "TICKET",
                    value: "DESK",
                    isHeader: true,
                  ),
                  Gap(12.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          list.length,
                          (index) => Column(
                            children: [
                              queueField(
                                context: context,
                                title: list[index].token.toString(),
                                value: "1",
                              ),
                              Gap(12.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }

  Row queueField({
    required BuildContext context,
    required String title,
    required String value,
    bool isHeader = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: isHeader ? Colors.white : Colors.black.withOpacity(0.25),
            ),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 5,
                color: isHeader ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: isHeader ? Colors.white : Colors.black.withOpacity(0.25),
            ),
            child: Text(
              value.toUpperCase(),
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 5,
                color: isHeader ? Colors.black : Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
