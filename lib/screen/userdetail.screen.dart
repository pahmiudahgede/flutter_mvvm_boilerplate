import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/component/avatars/avatar.component.dart';
import 'package:fluttercomponentui/component/cards/card.component.dart';
import 'package:fluttercomponentui/component/header/header.component.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

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
      title: user.name,
      subtitle: user.email,
      onBackPressed: () => context.pop(),
      centerWidget: ProfileAvatar(user: user),
      actions: [
        HeaderActionButton(
          icon: Icons.more_vert,
          onPressed: () {
            // Handle more actions
          },
        ),
      ],
    );
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
                value: user.name,
                icon: Icons.person_outline,
              ),
              DetailRow(
                label: 'Gender',
                value: user.gender,
                icon: Icons.wc_outlined,
              ),
              DetailRow(
                label: 'Date of Birth',
                value: user.dateOfBirth,
                icon: Icons.cake_outlined,
              ),
              DetailRow(
                label: 'Place of Birth',
                value: user.placeOfBirth,
                icon: Icons.location_on_outlined,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SectionHeader(
            title: 'Contact Information',
            padding: EdgeInsets.zero,
          ),
          SizedBox(height: 16.h),
          InfoCard(
            children: [
              DetailRow(
                label: 'Email Address',
                value: user.email,
                icon: Icons.email_outlined,
              ),
              DetailRow(
                label: 'Address',
                value: user.address,
                icon: Icons.home_outlined,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SectionHeader(
            title: 'Account Information',
            padding: EdgeInsets.zero,
          ),
          SizedBox(height: 16.h),
          InfoCard(
            children: [
              DetailRow(
                label: 'User ID',
                value: user.id,
                icon: Icons.badge_outlined,
              ),
              DetailRow(
                label: 'Created At',
                value: user.createdAt,
                icon: Icons.access_time_outlined,
              ),
              DetailRow(
                label: 'Updated At',
                value: user.updatedAt,
                icon: Icons.update_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}