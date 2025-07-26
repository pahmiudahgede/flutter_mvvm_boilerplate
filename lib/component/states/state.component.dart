import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';

/// Loading State Component
class LoadingState extends StatelessWidget {
  final String? message;
  final Color? indicatorColor;
  final double? size;

  const LoadingState({super.key, this.message, this.indicatorColor, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size?.w ?? 60.w,
            height: size?.w ?? 60.w,
            decoration: BoxDecoration(
              color: AppColors.lightGray.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular((size ?? 60) / 2),
            ),
            child: CircularProgressIndicator(
              color: indicatorColor ?? AppColors.primaryBlack,
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message!,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp),
            ),
          ],
        ],
      ),
    );
  }
}

/// Error State Component
class ErrorState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final IconData? icon;
  final Color? iconColor;

  const ErrorState({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.retryButtonText,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.error).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Icon(
                icon ?? Icons.error_outline,
                size: 40.sp,
                color: iconColor ?? AppColors.error,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlack,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  retryButtonText ?? 'Try Again',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty State Component
class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.iconColor,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.textLight).withValues(
                  alpha: 0.1,
                ),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Icon(
                icon ?? Icons.inbox_outlined,
                size: 40.sp,
                color: iconColor ?? AppColors.textLight,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[SizedBox(height: 24.h), action!],
          ],
        ),
      ),
    );
  }
}

/// No Internet State Component
class NoInternetState extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? customMessage;

  const NoInternetState({super.key, this.onRetry, this.customMessage});

  @override
  Widget build(BuildContext context) {
    return ErrorState(
      title: 'No Internet Connection',
      message:
          customMessage ??
          'Please check your internet connection and try again.',
      icon: Icons.wifi_off_outlined,
      iconColor: AppColors.warning,
      onRetry: onRetry,
      retryButtonText: 'Retry',
    );
  }
}

/// Success State Component
class SuccessState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onContinue;
  final String? buttonText;

  const SuccessState({
    super.key,
    required this.title,
    required this.message,
    this.onContinue,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 40.sp,
                color: AppColors.success,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            if (onContinue != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  buttonText ?? 'Continue',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Generic State Component untuk custom states
class GenericState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;
  final List<Widget>? actions;

  const GenericState({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    this.backgroundColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: backgroundColor ?? iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Icon(icon, size: 40.sp, color: iconColor),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            if (actions != null && actions!.isNotEmpty) ...[
              SizedBox(height: 24.h),
              ...actions!,
            ],
          ],
        ),
      ),
    );
  }
}
