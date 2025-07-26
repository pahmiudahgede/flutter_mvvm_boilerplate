import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercomponentui/core/utils/varguide.dart';
import 'package:intl/intl.dart';

class DateHelper {
  // Timezone for Indonesia (WIB = UTC+7)
  static const Duration _wibOffset = Duration(hours: 7);

  /// Formats ISO DateTime string to Indonesian format
  /// Input: "2004-09-01T17:00:00.000Z"
  /// Output: "02-09-2004" (adjusted to WIB timezone)
  static String formatFromISO(String isoString) {
    try {
      if (isoString.isEmpty) return '';

      // Parse UTC datetime
      final utcDateTime = DateTime.parse(isoString);

      // Convert to WIB (UTC+7)
      final wibDateTime = utcDateTime.add(_wibOffset);

      // Format to DD-MM-YYYY
      return DateFormat('dd-MM-yyyy').format(wibDateTime);
    } catch (e) {
      // If parsing fails, return original string or empty
      return isoString.isNotEmpty ? isoString : '';
    }
  }

  /// Formats Indonesian date string to ISO DateTime for API
  /// Input: "02-09-2004"
  /// Output: "2004-09-01T17:00:00.000Z" (converted from WIB to UTC)
  static String formatToISO(String indonesianDate) {
    try {
      if (indonesianDate.isEmpty) return '';

      // Parse DD-MM-YYYY format
      final dateParts = indonesianDate.split('-');
      if (dateParts.length != 3) return indonesianDate;

      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      // Create WIB datetime at noon to avoid timezone edge cases
      final wibDateTime = DateTime(year, month, day, 12, 0, 0);

      // Convert to UTC
      final utcDateTime = wibDateTime.subtract(_wibOffset);

      // Return ISO string
      return utcDateTime.toIso8601String();
    } catch (e) {
      // If parsing fails, return original string
      return indonesianDate;
    }
  }

  /// Formats current DateTime to Indonesian format
  /// Output: "26-07-2025"
  static String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }

  /// Formats current DateTime to ISO format for API
  /// Output: "2025-07-26T10:30:45.123Z"
  static String getCurrentDateISO() {
    return DateTime.now().toUtc().toIso8601String();
  }

  /// Formats ISO DateTime string to human readable format
  /// Input: "2025-07-26T10:30:45.123Z"
  /// Output: "26 Juli 2025, 17:30" (WIB time)
  static String formatToHumanReadable(String isoString) {
    try {
      if (isoString.isEmpty) return '';

      final utcDateTime = DateTime.parse(isoString);
      final wibDateTime = utcDateTime.add(_wibOffset);

      // Indonesian month names
      const months = [
        '',
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember',
      ];

      final day = wibDateTime.day;
      final month = months[wibDateTime.month];
      final year = wibDateTime.year;
      final hour = wibDateTime.hour.toString().padLeft(2, '0');
      final minute = wibDateTime.minute.toString().padLeft(2, '0');

      return '$day $month $year, $hour:$minute';
    } catch (e) {
      return isoString;
    }
  }

  /// Validates Indonesian date format (DD-MM-YYYY)
  static bool isValidIndonesianDate(String date) {
    try {
      if (date.isEmpty) return false;

      final regex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
      if (!regex.hasMatch(date)) return false;

      final parts = date.split('-');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      // Basic validation
      if (day < 1 || day > 31) return false;
      if (month < 1 || month > 12) return false;
      if (year < 1900 || year > 2100) return false;

      // Try to create DateTime to validate
      DateTime(year, month, day);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.icon,
    this.validator,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  Future<void> _selectDate() async {
    DateTime? initialDate;

    // Try to parse existing date
    if (widget.controller.text.isNotEmpty &&
        DateHelper.isValidIndonesianDate(widget.controller.text)) {
      try {
        final parts = widget.controller.text.split('-');
        initialDate = DateTime(
          int.parse(parts[2]), // year
          int.parse(parts[1]), // month
          int.parse(parts[0]), // day
        );
      } catch (e) {
        initialDate = null;
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          initialDate ?? DateTime.now().subtract(Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryBlack,
              onPrimary: AppColors.primaryWhite,
              surface: AppColors.backgroundSecondary,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      widget.controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.accentLight, width: 1),
      ),
      child: TextFormField(
        controller: widget.controller,
        readOnly: true, // Make it read-only to force date picker usage
        onTap: _selectDate,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.textSecondary,
            size: 20.sp,
          ),
          suffixIcon: Icon(
            Icons.calendar_today,
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
          hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14.sp),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
        style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp),
        validator: widget.validator,
      ),
    );
  }
}
