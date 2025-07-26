import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';

/// App Header dengan gradient background
class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actions,
    this.gradient,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(),
          SizedBox(height: 20.h),
          _buildTitleSection(),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        if (leadingIcon != null)
          _buildIconButton(icon: leadingIcon!, onPressed: onLeadingPressed)
        else
          const Spacer(),
        const Spacer(),
        if (actions != null) ...actions!,
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 8.h),
          Text(
            subtitle!,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 16.sp,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildIconButton({required IconData icon, VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

/// Detail Header untuk halaman detail
class DetailHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget? centerWidget;
  final Gradient? gradient;

  const DetailHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.actions,
    this.centerWidget,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBackPressed,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              if (actions != null) ...actions!,
            ],
          ),
          if (centerWidget != null) ...[SizedBox(height: 32.h), centerWidget!],
          if (title.isNotEmpty) ...[
            SizedBox(height: centerWidget != null ? 20.h : 32.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (subtitle != null) ...[
            SizedBox(height: 8.h),
            Text(
              subtitle!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Simple Header tanpa gradient
class SimpleHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showBackButton;

  const SimpleHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.textColor,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: backgroundColor ?? AppColors.backgroundCard,
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              onPressed: onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: textColor ?? AppColors.textPrimary,
              ),
            ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: textColor ?? AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: showBackButton ? TextAlign.start : TextAlign.center,
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

/// Section Header untuk membagi konten
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.padding,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  textAlign == TextAlign.center
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: textAlign,
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                    textAlign: textAlign,
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// Header Action Button
class HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? size;

  const HeaderActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? 40.w;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: buttonSize * 0.5,
        ),
      ),
    );
  }
}
