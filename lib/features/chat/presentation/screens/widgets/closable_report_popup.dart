import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<dynamic> showClosableReportPopup({
  required BuildContext context,
  required String title,
  String? content,
  required String buttonText,
  required VoidCallback onPressed,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: const Color(0xFFF5F5F5),
          contentPadding: EdgeInsets.fromLTRB(26.w, 19.h, 32.w, 31.h),
          title: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/splash/logo.svg',
                    height: 46.h,
                    width: 45.w,
                  ), // Show icon if path is provided
                  SizedBox(height: 24.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (content != null)
                    Text(
                      content, // Display content if provided
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF212221).withValues(alpha: 0.6),
                      ),
                    ),
                  SizedBox(height: 14.h),
                  Container(
                    height: 285.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 18.h,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Report Description',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9FA482).withValues(alpha: 0.42),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF2B361C),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // content: GreenButton(
          //   text: buttonText,
          //   onPressed: onPressed,
          // ),
        ),
  );
}
