import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../base_controller.dart';
import '../theme/theme.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    super.key,
    this.child,
    this.color,
    this.subTitle,
    this.controller,
  });

  final Widget? child;
  final Color? color;
  final String? subTitle;
  final BaseController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: color ?? Colors.transparent,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: subTitle != null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "$subTitle",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
              Expanded(child: child ?? const SizedBox()),
            ],
          ),
        ),
        Visibility(
          visible: controller != null,
          child: Obx(() {
            return Visibility(
              visible: controller!.busy.isTrue,
              child: Container(
                color: Colors.white.withOpacity(0.4),
                child: const Center(
                  child: LoaderView(),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class RowSpace extends StatelessWidget {
  final double? space;

  const RowSpace({
    super.key,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space ?? 16);
  }
}

class ColumnSpace extends StatelessWidget {
  final double? space;

  const ColumnSpace({
    super.key,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space ?? 16);
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.onPressed,
    this.wrap = false,
    this.text = "",
    this.fontSize,
    this.textPadding,
    this.backgroundColor,
    this.child,
    this.textColor,
    this.radius,
  });

  final VoidCallback? onPressed;
  final bool wrap;
  final String text;
  final double? fontSize;
  final double? textPadding;
  final double? radius;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Text buildText() {
      return Text(text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize ?? 17,
          ));
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? AppColor.buttonBgColor,
        shadowColor: Colors.greenAccent,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.0)),
      ),
      onPressed: onPressed,
      child: child ??
          Padding(
            padding: EdgeInsets.only(
                top: textPadding ?? 15.5, bottom: textPadding ?? 15.5),
            child: wrap
                ? buildText()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildText(),
                    ],
                  ),
          ),
    );
  }
}

class ThemeTextField extends StatelessWidget {
  const ThemeTextField({
    super.key,
    this.textEditingController,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.labelOnTop = false,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.decoration,
    this.hintText,
    this.suffix,
    this.padding,
    this.isDense,
    this.prefixText,
    this.focusNode,
    this.keyboardType,
    this.enabled,
    this.isRequired = false,
    this.validator,
    this.autovalidateMode,
    this.maxLength,
    this.expands = false,
    this.minLines,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.hideAsterisk = false, this.onTap,
  });

  final String? initialValue;
  final TextEditingController? textEditingController;
  final String? labelText;
  final String? errorText;
  final String? hintText;
  final String? prefixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool labelOnTop;
  final bool? isDense;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final Widget? suffix;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool isRequired;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final int? maxLength;
  final bool expands;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final bool hideAsterisk;
  final GestureTapCallback? onTap;

  const ThemeTextField.readOnly({
    super.key,
    this.initialValue,
    this.textEditingController,
    this.labelText,
    this.errorText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.labelOnTop = false,
    this.onChanged,
    this.suffix,
    this.padding,
    this.isDense,
    this.prefixText,
    this.focusNode,
    this.keyboardType,
    this.enabled,
    this.isRequired = false,
    this.validator,
    this.autovalidateMode,
    this.maxLength,
    this.expands = false,
    this.maxLines = 1,
    this.minLines,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.hideAsterisk = false, this.onTap,
  })  : readOnly = true,
        decoration = const InputDecoration(border: UnderlineInputBorder());

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(
      color: AppColor.formLabelColor,
      fontSize: 12,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    );

    RichText buildAsteriskText() {
      return RichText(
        text: TextSpan(text: '$labelText', style: labelStyle, children: [
          TextSpan(
              text: hideAsterisk ? '' : ' *',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 12))
        ]),
        /*          textScaleFactor: labelTextScale,
                    maxLines: labelMaxLines,
                    overflow: overflow,
                    textAlign: textAlign,*/
      );
    }

    var hintStyle = const TextStyle(
      color: Color(0x7F2D2D2D),
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      height: 0,
    );

    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: labelOnTop,
            child: Padding(
              padding: EdgeInsets.only(bottom: (labelText == null) ? 0 : 8.0),
              child: isRequired
                  ? buildAsteriskText()
                  : Text(labelText ?? "", style: labelStyle),
            ),
          ),
          TextFormField(
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            obscureText: obscureText,
            autofocus: false,
            expands: expands,
            maxLines: maxLines,
            minLines: minLines,
            keyboardType: keyboardType,
            readOnly: readOnly,
            focusNode: focusNode,
            initialValue: initialValue,
            onChanged: onChanged,
            enabled: enabled,
            maxLength: maxLength,
            controller: initialValue == null ? textEditingController : null,
            decoration: decoration ??
                InputDecoration(
                    isDense: isDense,
                    labelText:
                        isRequired ? null : (labelOnTop ? null : labelText),
                    label: labelOnTop
                        ? null
                        : (isRequired ? buildAsteriskText() : null),
                    errorText: errorText,
                    hintText: hintText,
                    hintStyle: hintStyle,
                    prefixText: prefixText,
                    labelStyle: labelStyle,
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: AppColor.colorBorderSideError, width: 1)),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: AppColor.colorBorderSideError, width: 1)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: AppColor.colorBorderSide, width: 1)),
                    focusedBorder: readOnly
                        ? const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: AppColor.colorBorderSide, width: 1))
                        : const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: AppColor.colorBorderSideFocused,
                                width: 1)),
                    suffixIcon: suffix == null ? suffixIcon : null,
                    suffix: suffix,
                    prefixIcon: prefixIcon),
            validator: validator ??
                (isRequired
                    ? (changed) {
                        String ch = changed ?? "";
                        return ch.isEmpty ? "$labelText is required" : null;
                      }
                    : validator),
            autovalidateMode: autovalidateMode ??
                (isRequired
                    ? AutovalidateMode.onUserInteraction
                    : autovalidateMode),
          ),
        ],
      ),
    );
  }
}

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({
    super.key,
    required this.titleText,
    // required this.controller,
  });

  // final BaseController controller;

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: const TextStyle(
        color: AppColor.authAppbarTitleColor,
        fontSize: 18,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      title: Text(titleText),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class LoaderView extends StatelessWidget {
  const LoaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Shimmer.fromColors(
          direction: ShimmerDirection.ttb,
          baseColor: AppColor.colorPrimary.withAlpha(190),
          highlightColor: Colors.grey.shade50,
          child: Image.asset(
            "assets/images/nondito_loader.png",
            fit: BoxFit.contain,
          )),
    );
  }
}

class AlertText extends StatelessWidget {
  final String alertText;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final GestureTapCallback? onTap;

  const AlertText(
      {super.key,
      required this.alertText,
      this.backgroundColor,
      this.foregroundColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.colorPrimaryBg,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.all(2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              alertText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: foregroundColor ?? AppColor.colorPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          onTap == null
              ? SizedBox()
              : InkWell(
                  onTap: onTap,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: foregroundColor ?? AppColor.colorPrimary,
                  ),
                )
        ],
      ),
    );
  }

  const AlertText.primary({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorPrimaryBg,
        foregroundColor = AppColor.colorPrimary;

  const AlertText.primaryInverse({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorPrimary,
        foregroundColor = AppColor.colorPrimaryBg;

  const AlertText.success({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorSuccessBg,
        foregroundColor = AppColor.colorSuccess;

  const AlertText.successInverse({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorSuccess,
        foregroundColor = AppColor.colorSuccessBg;

  const AlertText.info({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorInfoBg,
        foregroundColor = AppColor.colorInfo;

  const AlertText.infoInverse({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorInfoBg,
        foregroundColor = AppColor.colorInfo;

  const AlertText.warn({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorWarnBg,
        foregroundColor = AppColor.colorWarn;

  const AlertText.warnInverse({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorWarn,
        foregroundColor = AppColor.colorWarnBg;

  const AlertText.danger({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorDangerBg,
        foregroundColor = AppColor.colorDanger;

  const AlertText.dangerInverse({
    super.key,
    required this.alertText,
    this.onTap,
  })  : backgroundColor = AppColor.colorDanger,
        foregroundColor = AppColor.colorDangerBg;
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor:
            (Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
        highlightColor:
            Get.isDarkMode ? Colors.grey.shade600 : Colors.grey.shade100,
        child: child);
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key, required this.child, this.length = 10});

  final Widget child;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: List.generate(length, (i) => ShimmerWidget(child: child)));
  }
}
