import 'package:flutter/material.dart';

class DialogService {
  Future showLoadingDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(4)
              ),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  void closeDialog({required BuildContext context}) {
    Navigator.pop(context);
  }
}
