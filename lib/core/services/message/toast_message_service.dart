import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../../features/app/presentation/base_widgets/text/text_widget.dart';
import '../../constants/app_color.dart';
import '../../data/states/data_state.dart';
import '../../utils/ui_helper.dart';

abstract class ToastMessageService {
  setContext(BuildContext context);
  showSuccess(String message, {Duration? duration});
  showError(String message, {Duration? duration});
  showDataStateToast(DataState dataState, {String message = ""});
}

@LazySingleton(as: ToastMessageService)
class ToastMessageServiceImplementation implements ToastMessageService {
  BuildContext? _context;
  final _toastSetting = const SlidingToastSetting(
    displayDuration: Duration(seconds: 2),
    toastStartPosition: ToastPosition.top,
    toastAlignment: Alignment.topCenter,
  );
  final EdgeInsets _padding = UIHelper.xSmallAllPadding;
  final BoxShadow _boxShadow = const BoxShadow(
    color: AppColor.black05,
    spreadRadius: 2,
    blurRadius: 4,
  );

  /// Configure context for toast message,
  /// so that it can be shown without context later.
  @override
  setContext(BuildContext context) => _context = context;

  @override
  showSuccess(String message, {Duration? duration}) {
    if (_context == null) return;
    InteractiveToast.slide(
      _context!,
      title: Text(message),
      trailing: const Icon(
        Icons.check_circle_rounded,
        color: AppColor.green500,
        size: 25,
      ),
      toastSetting: _toastSetting.copyWith(displayDuration: duration),
      toastStyle: ToastStyle(
        padding: _padding,
        progressBarColor: AppColor.green500,
        boxShadow: [_boxShadow],
      ),
    );
  }

  @override
  showError(String message, {Duration? duration}) {
    if (_context == null) return;
    InteractiveToast.slide(
      _context!,
      title: TextWidget(message),
      trailing: const Icon(
        Icons.warning_rounded,
        color: AppColor.red600,
        size: 25,
      ),
      toastSetting: _toastSetting.copyWith(displayDuration: duration),
      toastStyle: ToastStyle(
        padding: _padding,
        progressBarColor: AppColor.red600,
        boxShadow: [_boxShadow],
      ),
    );
  }

  /// Shows success or error message based on success and failure state
  @override
  showDataStateToast(DataState dataState, {String message = ""}) {
    if (dataState is! SuccessState) {
      showError(dataState.message!);
    } else if (message.isNotEmpty) {
      showSuccess(message);
    }
  }
}

/// A util class for accessing [ToastMessageService]
class ToastMessageUtil {
  ToastMessageUtil._();

  /// Returns the registered instance of [ToastMessageService] which is always the same
  static ToastMessageService get I => GetIt.I<ToastMessageService>();
}
