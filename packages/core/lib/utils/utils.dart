import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String getFormatYear(String? value) {
  if (value == null) {
    return '0000';
  }

  var input = DateFormat.y().parse(value);
  var output = DateFormat.y().format(input);
  return output;
}

String getFormatDate(String? value) {
  if (value == null) {
    return '0000-00-00';
  }

  var input = DateFormat.y().parse(value);
  var output = DateFormat.yMMMMd().format(input);
  return output;
}

isAlertDialogShowing(BuildContext ctx) => ModalRoute.of(ctx)?.isCurrent != true;

closeAlertDialog(BuildContext ctx) {
  if (isAlertDialogShowing(ctx)) {
    Navigator.of(ctx).pop();
  }
}
