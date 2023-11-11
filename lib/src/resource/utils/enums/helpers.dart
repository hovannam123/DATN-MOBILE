import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/utils/enums/app_strings.dart';

Future<T?> showLoading<T extends Object?>(BuildContext context,
    {String? message}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 100.0,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Container(
                margin: const EdgeInsets.all(4.0),
                child: Text(message ?? AppStrings.loadingData),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<T?> showErrorDialog<T extends Object?>(
    BuildContext context, dynamic error) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text(AppStrings.error),
        content: Text(error.toString().replaceFirst('Exception: ', '')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(AppStrings.confirm),
          ),
        ],
      ),
    );
  }
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        // title: const Text("Fail"),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ],
        content: Text(error.toString().replaceFirst('Exception: ', '')),
      );
    },
  );
}

// Future<T?> showSuccessDialog<T extends Object?>(
//     BuildContext context, Exception error) {
//   return showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text(AppStrings.error),
//       content: Text(error.toString().split("Exveption:")[0]),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text(AppStrings.confirm),
//         ),
//       ],
//     ),
//   );
// }

void showSuccessDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style:
            const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.grey,
    ),
  );
}

void showMaterialDialog(
    BuildContext context, String title, String message, VoidCallback? onOk) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppTextStyle.heading3Black,
          ),
          content: Text(
            message,
            style: AppTextStyle.heading3Black,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: onOk,
                child: const Text(
                  'Ok',
                  style: AppTextStyle.heading3Black,
                )),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: AppTextStyle.heading3Black,
              ),
            )
          ],
        );
      });
}
