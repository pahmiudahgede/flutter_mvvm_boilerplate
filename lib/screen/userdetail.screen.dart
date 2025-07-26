import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/component/avatars/avatar.component.dart';
import 'package:fluttercomponentui/component/cards/card.component.dart';
import 'package:fluttercomponentui/component/header/header.component.dart';
import 'package:fluttercomponentui/core/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';
import 'package:fluttercomponentui/data/user/user.vmod.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildUserDetails()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return DetailHeader(
      title: currentUser.name,
      subtitle: currentUser.email,
      onBackPressed: () => router.pop(),
      centerWidget: ProfileAvatar(user: currentUser),
      actions: [
        HeaderActionButton(
          icon: Icons.more_vert,
          onPressed: () => _showActionMenu(context),
        ),
      ],
    );
  }

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 24.h),

                // Title
                Text(
                  'User Actions',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 24.h),

                // Edit Action
                _buildActionTile(
                  icon: Icons.edit_outlined,
                  title: 'Edit User',
                  subtitle: 'Modify user information',
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToEditUser();
                  },
                ),

                SizedBox(height: 16.h),

                // Delete Action
                _buildActionTile(
                  icon: Icons.delete_outline,
                  title: 'Delete User',
                  subtitle: 'Remove user permanently',
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(context);
                  },
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color:
              isDestructive
                  ? AppColors.error.withValues(alpha: 0.05)
                  : AppColors.accentLight.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isDestructive
                    ? AppColors.error.withValues(alpha: 0.2)
                    : AppColors.accentLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color:
                    isDestructive
                        ? AppColors.error.withValues(alpha: 0.1)
                        : AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppColors.error : AppColors.info,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color:
                          isDestructive
                              ? AppColors.error
                              : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: AppColors.lightGray,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditUser() async {
    final result = await router.push('/edit-user', extra: currentUser);

    // If user was updated, refresh the current user data
    if (result is User) {
      setState(() {
        currentUser = result;
      });
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.backgroundSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.warning,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Delete User',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to delete this user?',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.r,
                        backgroundImage: NetworkImage(currentUser.avatar),
                        onBackgroundImageError: (_, __) {},
                        child:
                            currentUser.avatar.isEmpty
                                ? Icon(Icons.person, size: 16.sp)
                                : null,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              currentUser.email,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'This action cannot be undone.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleDeleteUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _handleDeleteUser() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.backgroundSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.error),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Deleting user...',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
    );

    try {
      final success = await context.read<UserViewModel>().deleteUser(
        currentUser.id,
      );

      // Close loading dialog
      if (mounted) Navigator.pop(context);

      if (success) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.primaryWhite,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    '${currentUser.name} deleted successfully!',
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              duration: const Duration(seconds: 3),
            ),
          );

          // Navigate back to user list
          router.go('/');
        }
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) Navigator.pop(context);

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: AppColors.primaryWhite, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Failed to delete user. Please try again.',
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Widget _buildUserDetails() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Personal Information',
            padding: EdgeInsets.zero,
          ),
          SizedBox(height: 16.h),
          InfoCard(
            children: [
              DetailRow(
                label: 'Full Name',
                value: currentUser.name,
                icon: Icons.person_outline,
              ),
              DetailRow(
                label: 'Gender',
                value: currentUser.gender,
                icon: Icons.wc_outlined,
              ),
              DetailRow(
                label: 'Date of Birth',
                value: currentUser.dateOfBirthReadable, // Human readable format
                icon: Icons.cake_outlined,
              ),
              DetailRow(
                label: 'Place of Birth',
                value: currentUser.placeOfBirth,
                icon: Icons.location_on_outlined,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SectionHeader(title: 'Contact Information', padding: EdgeInsets.zero),
          SizedBox(height: 16.h),
          InfoCard(
            children: [
              DetailRow(
                label: 'Email Address',
                value: currentUser.email,
                icon: Icons.email_outlined,
              ),
              DetailRow(
                label: 'Address',
                value: currentUser.address,
                icon: Icons.home_outlined,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SectionHeader(title: 'Account Information', padding: EdgeInsets.zero),
          SizedBox(height: 16.h),
          InfoCard(
            children: [
              DetailRow(
                label: 'User ID',
                value: currentUser.id,
                icon: Icons.badge_outlined,
              ),
              DetailRow(
                label: 'Created At',
                value: currentUser.createdAtReadable, // Human readable format
                icon: Icons.access_time_outlined,
              ),
              DetailRow(
                label: 'Updated At',
                value: currentUser.updatedAtReadable, // Human readable format
                icon: Icons.update_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
