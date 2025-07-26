// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/core/utils/router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';
import 'package:fluttercomponentui/data/user/user.vmod.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  const EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _placeOfBirthController;
  late TextEditingController _addressController;

  late String _selectedGender;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _dateOfBirthController = TextEditingController(text: widget.user.dateOfBirth);
    _placeOfBirthController = TextEditingController(text: widget.user.placeOfBirth);
    _addressController = TextEditingController(text: widget.user.address);
    _selectedGender = widget.user.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    _placeOfBirthController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserCard(),
                      SizedBox(height: 32.h),
                      _buildSectionTitle('Personal Information'),
                      SizedBox(height: 16.h),
                      _buildNameField(),
                      SizedBox(height: 16.h),
                      _buildGenderField(),
                      SizedBox(height: 16.h),
                      _buildDateOfBirthField(),
                      SizedBox(height: 16.h),
                      _buildPlaceOfBirthField(),
                      SizedBox(height: 24.h),
                      _buildSectionTitle('Contact Information'),
                      SizedBox(height: 16.h),
                      _buildAddressField(),
                      SizedBox(height: 16.h),
                      _buildEmailField(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundPrimary,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.textPrimary,
          size: 20.sp,
        ),
        onPressed: () => router.pop(),
      ),
      title: Text(
        'Edit User',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildUserCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accentLight,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: NetworkImage(widget.user.avatar),
            onBackgroundImageError: (_, __) {},
            child: widget.user.avatar.isEmpty 
                ? Icon(Icons.person, size: 24.sp) 
                : null,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.user.email,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'ID: ${widget.user.id}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildNameField() {
    return _buildTextFormField(
      controller: _nameController,
      label: 'Full Name',
      hintText: 'Enter full name',
      icon: Icons.person_outline,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Full name is required';
        }
        if (value!.length < 2) {
          return 'Name must be at least 2 characters';
        }
        return null;
      },
    );
  }

  Widget _buildGenderField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.accentLight,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        child: Row(
          children: [
            Icon(
              Icons.wc_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
                dropdownColor: AppColors.backgroundSecondary,
                items: ['Male', 'Female'].map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(
                      gender,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    return _buildTextFormField(
      controller: _dateOfBirthController,
      label: 'Date of Birth',
      hintText: 'DD-MM-YYYY (e.g., 15-01-1990)',
      icon: Icons.calendar_today_outlined,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Date of birth is required';
        }
        if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value!)) {
          return 'Use DD-MM-YYYY format';
        }
        return null;
      },
    );
  }

  Widget _buildPlaceOfBirthField() {
    return _buildTextFormField(
      controller: _placeOfBirthController,
      label: 'Place of Birth',
      hintText: 'Enter place of birth',
      icon: Icons.location_on_outlined,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Place of birth is required';
        }
        return null;
      },
    );
  }

  Widget _buildAddressField() {
    return _buildTextFormField(
      controller: _addressController,
      label: 'Address',
      hintText: 'Enter full address',
      icon: Icons.home_outlined,
      maxLines: 3,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Address is required';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return _buildTextFormField(
      controller: _emailController,
      label: 'Email Address',
      hintText: 'Enter email address',
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Email is required';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.accentLight,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.textSecondary,
            size: 20.sp,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          labelStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
          ),
          hintStyle: TextStyle(
            color: AppColors.textLight,
            fontSize: 14.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16.sp,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        border: Border(
          top: BorderSide(
            color: AppColors.accentLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isLoading ? null : () => router.pop(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                side: BorderSide(
                  color: AppColors.lightGray,
                  width: 1,
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleUpdateUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlack,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryWhite,
                        ),
                      ),
                    )
                  : Text(
                      'Update User',
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleUpdateUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await context.read<UserViewModel>().updateUser(
        id: widget.user.id,
        name: _nameController.text.trim(),
        gender: _selectedGender,
        dateOfBirth: _dateOfBirthController.text.trim(),
        placeOfBirth: _placeOfBirthController.text.trim(),
        address: _addressController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (success) {
        // Get updated user from ViewModel
        final updatedUser = context.read<UserViewModel>().users
            .firstWhere((user) => user.id == widget.user.id);

        if (mounted) {
          // Show success message
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
                    'User updated successfully!',
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

          // Navigate back to user detail with updated user
          context.pop(updatedUser);
        }
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error,
                  color: AppColors.primaryWhite,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Failed to update user. Please try again.',
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}