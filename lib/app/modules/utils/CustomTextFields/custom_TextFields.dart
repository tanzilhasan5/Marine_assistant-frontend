import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';
import '../styles.dart';

class CustomtextField extends StatefulWidget {
  final String hintText;

  // Validator
  final String? Function(String?)? validator;

  // Top label
  final String? upLabelText;
  final TextStyle? upLabelStyle;

  // Input field label
  final String? labelText;
  final TextStyle? labelStyle;

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readonly;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Color? fillColor;
  final Color? backgroundColor;
  final Color? borderColor;

  final Color? errorBorderColor;
  final double errorBorderRadius;

  // Layout
  final double height;
  final double width;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  final VoidCallback? onTap;
  final FocusNode? focusNode;

  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  // Password visibility toggle
  final bool showPasswordToggle;

  final TextAlign textAlign;

  // NEW: Icon colors
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? focusedPrefixIconColor;
  final Color? focusedSuffixIconColor;

  const CustomtextField({
    super.key,
    required this.hintText,
    this.validator,
    this.upLabelText,
    this.upLabelStyle,
    this.labelText,
    this.labelStyle,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.backgroundColor,
    this.borderColor,
    this.errorBorderColor = Colors.red,
    this.errorBorderRadius = 8,
    this.height = 60,
    this.width = double.infinity,
    this.borderRadius = 24,
    this.contentPadding,
    this.onTap,
    this.focusNode,
    this.hintStyle,
    this.textStyle,
    this.showPasswordToggle = false,
    this.prefixIconColor,
    this.suffixIconColor,
    this.focusedPrefixIconColor,
    this.focusedSuffixIconColor,
    this.readonly = false,
    this.textAlign = TextAlign.start,
  });

  @override
  State<CustomtextField> createState() => _CustomtextFieldState();
}

class _CustomtextFieldState extends State<CustomtextField> {
  late bool _isPasswordVisible;
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = !widget.obscureText;
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  Color _getPrefixIconColor() {
    if (_isFocused && widget.focusedPrefixIconColor != null) {
      return widget.focusedPrefixIconColor!;
    }
    return widget.prefixIconColor ?? AppColor.secondarytextColor;
  }

  Color _getSuffixIconColor() {
    if (_isFocused && widget.focusedSuffixIconColor != null) {
      return widget.focusedSuffixIconColor!;
    }
    return widget.suffixIconColor ?? AppColor.secondarytextColor;
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon == null) return null;

    return Center(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: IconTheme(
        data: IconThemeData(color: _getPrefixIconColor()),
        child: widget.prefixIcon!,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.showPasswordToggle) {
      return Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: _getSuffixIconColor(),
            size: 24.sp,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      );
    }

    if (widget.suffixIcon == null) return null;

    return Center(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: IconTheme(
        data: IconThemeData(color: _getSuffixIconColor()),
        child: widget.suffixIcon!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.upLabelText != null) ...[
          Text(widget.upLabelText!, style: widget.upLabelStyle),
          SizedBox(height: 5.h),
        ],
        Container(
          height: widget.height.h,
          width: widget.width.w == double.infinity
              ? widget.width
              : widget.width.w,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
          ),
          child: TextFormField(
            readOnly: widget.readonly,
            validator: widget.validator,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.showPasswordToggle
                ? !_isPasswordVisible
                : widget.obscureText,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            onTap: widget.onTap,
            focusNode: _internalFocusNode,
            textAlign: widget.textAlign,
            textAlignVertical: TextAlignVertical.center,
            style:
                widget.textStyle ??
                AppTextStyles.title16_w500(color: Colors.white),
            decoration:
            InputDecoration(
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  AppTextStyles.title16_w400(
                    color: AppColor.secondarytextColor,
                  ),
              prefixIcon: _buildPrefixIcon(),
              suffixIcon: _buildSuffixIcon(),
              prefixIconConstraints: BoxConstraints(
                minWidth: 48.w,
                minHeight: widget.height.h,
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: 48.w,
                minHeight: widget.height.h,
              ),
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: ((widget.height - 18) / 2).h,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
