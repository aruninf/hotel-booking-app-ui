import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nudge/core/extension/extensions.dart';

export 'package:flutter/material.dart';
export 'package:form_validator/form_validator.dart';
export 'package:get/get.dart';
export 'package:nudge/core/constants/app_colors.dart';
export 'package:nudge/core/constants/app_constant.dart';
export 'package:nudge/core/constants/app_endpoints.dart';
export 'package:nudge/core/dio_provider/api_error.dart';
export 'package:nudge/core/enum/the_states.dart';
export 'package:nudge/core/routes/app_routes.dart';
export 'package:nudge/gen/assets.gen.dart';
export 'package:nudge/utlis/app_globals.dart';
export 'package:nudge/utlis/app_text_styles.dart';
export 'package:nudge/utlis/app_utils.dart';
export 'package:nudge/utlis/app_validators.dart';
export 'package:nudge/utlis/app_widget_key.dart';
export 'package:nudge/utlis/navigation_helper.dart';
export 'package:nudge/utlis/uihelper.dart';
export 'package:nudge/utlis/url_launcher_utls.dart';

export '../../common/common_extentions.dart';
export '../constants/app_font_size.dart';
export '../constants/app_images.dart';
export '../theme/text_theme.dart';
export './date_extension.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get text => theme.textTheme;

  double get devicePaddingTop => MediaQuery.of(this).padding.top;

  double get devicePaddingBottom => MediaQuery.of(this).padding.bottom;

  double get viewInsets => MediaQuery.of(this).viewInsets.bottom;

  double get deviceHeight => MediaQuery.of(this).size.height;

  double get deviceWidth => MediaQuery.of(this).size.width;

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(this).unfocus();
  }

  String getInitials(String name) {
    var nameParts = name.split(' ');
    var firstNameInitial = '';
    var lastNameInitial = '';

    if (nameParts.isEmpty || name == '') {
      return '';
    } else if (nameParts.length == 1) {
      return firstNameInitial = nameParts[0][0].toUpperCase();
    } else {
      firstNameInitial = nameParts[0][0].toUpperCase();
      lastNameInitial = nameParts.last[0].toUpperCase();

      return firstNameInitial + lastNameInitial;
    }
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}

String engDateAsString(
  String? date, {
  String format = AppConstants.standardDateFormat,
}) {
  return (date == null || date == 'null')
      ? 'N/A'
      : DateFormat(format).format(DateTime.parse(date));
}

String formatString(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}
