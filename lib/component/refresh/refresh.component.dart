import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';

/// Custom Refresh Indicator dengan animasi yang smooth
class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? indicatorColor;
  final double? strokeWidth;
  final double? size;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.indicatorColor,
    this.strokeWidth,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? _) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (!controller.isIdle)
                  Positioned(
                    top: 35.0 * controller.value,
                    child: SizedBox(
                      height: size?.h ?? 30.h,
                      width: size?.h ?? 30.h,
                      child: CircularProgressIndicator(
                        color: indicatorColor ?? AppColors.primaryBlack,
                        strokeWidth: strokeWidth ?? 3.0,
                        value:
                            controller.isDragging || controller.isArmed
                                ? controller.value.clamp(0.0, 1.0)
                                : null,
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 80.0 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}

/// Refresh Indicator dengan custom design
class CustomAppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final IconData? icon;
  final String? refreshText;

  const CustomAppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.backgroundColor,
    this.indicatorColor,
    this.icon,
    this.refreshText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? _) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (!controller.isIdle)
                  Positioned(
                    top: 20.0 * controller.value,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor ?? AppColors.backgroundCard,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.isLoading)
                            SizedBox(
                              width: 16.w,
                              height: 16.w,
                              child: CircularProgressIndicator(
                                color: indicatorColor ?? AppColors.primaryBlack,
                                strokeWidth: 2.0,
                              ),
                            )
                          else
                            Icon(
                              icon ?? Icons.refresh,
                              color: indicatorColor ?? AppColors.primaryBlack,
                              size: 16.sp,
                            ),
                          if (refreshText != null) ...[
                            SizedBox(width: 8.w),
                            Text(
                              controller.isLoading
                                  ? 'Refreshing...'
                                  : refreshText!,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 60.0 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}

/// Pull to refresh dengan bounce effect
class BounceRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? indicatorColor;
  final double bounceHeight;

  const BounceRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.indicatorColor,
    this.bounceHeight = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? _) {
            final bounceValue = controller.value * bounceHeight;

            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (!controller.isIdle)
                  Positioned(
                    top: bounceValue * 0.5,
                    child: Transform.scale(
                      scale: controller.value.clamp(0.0, 1.0),
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: indicatorColor ?? AppColors.primaryBlack,
                          shape: BoxShape.circle,
                        ),
                        child:
                            controller.isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                )
                                : Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, bounceValue),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}

/// Refresh indicator dengan lottie animation (jika menggunakan lottie)
class AnimatedRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Widget? customIndicator;
  final Duration animationDuration;

  const AnimatedRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.customIndicator,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? _) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (!controller.isIdle)
                  Positioned(
                    top: 40.0 * controller.value,
                    child: AnimatedOpacity(
                      opacity: controller.value,
                      duration: animationDuration,
                      child:
                          customIndicator ??
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlack.withValues(
                                alpha: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 80.0 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}
