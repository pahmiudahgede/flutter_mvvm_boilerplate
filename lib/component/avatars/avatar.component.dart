import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/component/shimmer/shimmer.component.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';

/// User Avatar Component
class UserAvatar extends StatelessWidget {
  final User user;
  final double size;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final bool showBorder;

  const UserAvatar({
    super.key,
    required this.user,
    required this.size,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? (size * 0.25);
    final innerRadius = radius - (borderWidth ?? 2);

    return Container(
      width: size,
      height: size,
      decoration:
          showBorder
              ? BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  color: borderColor ?? AppColors.accentLight,
                  width: borderWidth ?? 2,
                ),
              )
              : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(showBorder ? innerRadius : radius),
        child: _buildAvatarContent(),
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (user.avatar.isNotEmpty && user.avatar.startsWith('http')) {
      return Image.network(
        user.avatar,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return AvatarLoadingShimmer(size: size, borderRadius: borderRadius);
        },
      );
    }
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    return Container(
      decoration: BoxDecoration(gradient: _getAvatarGradient(user.gender)),
      child: Center(
        child: Text(
          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  LinearGradient _getAvatarGradient(String gender) {
    if (gender.toLowerCase() == 'female') {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.lightGray, AppColors.accentDark],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.accentMedium, AppColors.primaryBlack],
      );
    }
  }
}

/// Profile Avatar dengan shadow untuk detail screen
class ProfileAvatar extends StatelessWidget {
  final User user;
  final double size;
  final double? borderRadius;
  final List<BoxShadow>? shadows;

  const ProfileAvatar({
    super.key,
    required this.user,
    this.size = 100,
    this.borderRadius,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? (size * 0.28);

    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 3,
        ),
        boxShadow:
            shadows ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - 3),
        child: _buildAvatarContent(),
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (user.avatar.isNotEmpty && user.avatar.startsWith('http')) {
      return Image.network(
        user.avatar,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return AvatarLoadingShimmer(
            size: size.w,
            borderRadius: borderRadius,
            baseColor: Colors.white.withValues(alpha: 0.3),
            highlightColor: Colors.white.withValues(alpha: 0.1),
          );
        },
      );
    }
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    return Container(
      decoration: BoxDecoration(gradient: _getAvatarGradient(user.gender)),
      child: Center(
        child: Text(
          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: Colors.white,
            fontSize: (size * 0.36).sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  LinearGradient _getAvatarGradient(String gender) {
    if (gender.toLowerCase() == 'female') {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.lightGray, AppColors.accentDark],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.accentMedium, AppColors.primaryBlack],
      );
    }
  }
}

/// Generic Avatar untuk use case lain
class GenericAvatar extends StatelessWidget {
  final String? imageUrl;
  final String fallbackText;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final Gradient? gradient;

  const GenericAvatar({
    super.key,
    this.imageUrl,
    required this.fallbackText,
    required this.size,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? (size * 0.25);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor ?? AppColors.primaryBlack,
        gradient: gradient,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return AvatarLoadingShimmer(size: size);
        },
      );
    }
    return _buildFallback();
  }

  Widget _buildFallback() {
    return Center(
      child: Text(
        fallbackText.isNotEmpty ? fallbackText[0].toUpperCase() : '?',
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: size * 0.35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
