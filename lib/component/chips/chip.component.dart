import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Info Chip Component
class InfoChip extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final VoidCallback? onTap;

  const InfoChip({
    super.key,
    required this.text,
    required this.color,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget chip = Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: chip);
    }

    return chip;
  }
}

/// Status Chip dengan berbagai status
class StatusChip extends StatelessWidget {
  final String text;
  final ChipStatus status;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final VoidCallback? onTap;

  const StatusChip({
    super.key,
    required this.text,
    required this.status,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = _getStatusColor(status);

    return InfoChip(
      text: text,
      color: chipColor,
      fontSize: fontSize,
      padding: padding,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }

  Color _getStatusColor(ChipStatus status) {
    switch (status) {
      case ChipStatus.success:
        return Colors.green;
      case ChipStatus.warning:
        return Colors.orange;
      case ChipStatus.error:
        return Colors.red;
      case ChipStatus.info:
        return Colors.blue;
      case ChipStatus.neutral:
        return Colors.grey;
    }
  }
}

/// Category Chip dengan icon
class CategoryChip extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final VoidCallback? onTap;
  final bool selected;

  const CategoryChip({
    super.key,
    required this.text,
    required this.color,
    this.icon,
    this.iconSize,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget chip = Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: selected ? color : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        border:
            selected ? null : Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: iconSize ?? 14.sp,
              color: selected ? Colors.white : color,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : color,
              fontSize: fontSize ?? 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: chip);
    }

    return chip;
  }
}

/// Deletable Chip
class DeletableChip extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onDelete;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const DeletableChip({
    super.key,
    required this.text,
    required this.color,
    this.onDelete,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: fontSize ?? 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (onDelete != null) ...[
            SizedBox(width: 4.w),
            GestureDetector(
              onTap: onDelete,
              child: Icon(Icons.close, size: 14.sp, color: color),
            ),
          ],
        ],
      ),
    );
  }
}

/// Enum untuk status chip
enum ChipStatus { success, warning, error, info, neutral }
