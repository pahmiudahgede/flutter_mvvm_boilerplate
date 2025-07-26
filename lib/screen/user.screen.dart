import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/component/cards/card.component.dart';
import 'package:fluttercomponentui/component/header/header.component.dart';
import 'package:fluttercomponentui/component/refresh/refresh.component.dart';
import 'package:fluttercomponentui/component/shimmer/shimmer.component.dart';
import 'package:fluttercomponentui/component/states/state.component.dart';
import 'package:fluttercomponentui/core/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';
import 'package:fluttercomponentui/data/user/user.vmod.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 24.h),
            _buildStatsCards(),
            SizedBox(height: 24.h),
            _buildUsersList(),
          ],
        ),
      ),
      floatingActionButton: _buildAddButton(),
    );
  }

  Widget _buildHeader() {
    return AppHeader(
      title: 'User Management',
      subtitle: 'Manage your user data easily',
      leadingIcon: Icons.people,
      actions: [
        HeaderActionButton(
          icon: Icons.refresh,
          onPressed: () {
            context.read<UserViewModel>().getAllUsers();
          },
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return FloatingActionButton(
      onPressed: () {
        router.push('/add-user');
      },
      backgroundColor: AppColors.primaryBlack,
      foregroundColor: AppColors.primaryWhite,
      child: const Icon(Icons.add),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == UserState.loading) {
            return _buildStatsShimmer();
          }

          return Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Total Users',
                  value: '${viewModel.users.length}',
                  color: AppColors.info,
                  icon: Icons.people_outline,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: StatsCard(
                  title: 'Active',
                  value: '${viewModel.users.length}',
                  color: AppColors.success,
                  icon: Icons.check_circle_outline,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsShimmer() {
    return Row(
      children: [
        const Expanded(child: StatsCardShimmer()),
        SizedBox(width: 16.w),
        const Expanded(child: StatsCardShimmer()),
      ],
    );
  }

  Widget _buildUsersList() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Recent Users', padding: EdgeInsets.zero),
            SizedBox(height: 16.h),
            Expanded(
              child: Consumer<UserViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.state == UserState.loading) {
                    return _buildUsersShimmer();
                  }

                  if (viewModel.state == UserState.error) {
                    return ErrorState(
                      title: 'Oops! Something went wrong',
                      message: viewModel.errorMessage,
                      onRetry: () {
                        viewModel.clearError();
                        viewModel.getAllUsers();
                      },
                    );
                  }

                  if (viewModel.users.isEmpty) {
                    return const EmptyState(
                      title: 'No Users Found',
                      message: 'There are no users to display at the moment',
                      icon: Icons.people_outline,
                    );
                  }

                  return AppRefreshIndicator(
                    onRefresh: () => viewModel.getAllUsers(),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: viewModel.users.length,
                      itemBuilder: (context, index) {
                        final user = viewModel.users[index];
                        return UserCard(
                          user: user,
                          onTap: () {
                            router.push('/user-detail', extra: user);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersShimmer() {
    return ShimmerList(
      itemCount: 6,
      itemBuilder: (context, index) => const UserCardShimmer(),
    );
  }
}
