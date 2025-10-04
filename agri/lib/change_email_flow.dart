import 'package:flutter/material.dart';
import 'common_input_widget.dart';
import 'enter_new.dart';  // ← your updated EnterNew file

/// Returns NEW e‑mail back to caller (or null if cancelled)
class ChangeEmailFlow extends StatelessWidget {
  const ChangeEmailFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return EnterCurrent(
      title: 'Change Email',
      hint : 'Current email',
      onNext: (currentEmail, pwd) async {
        /// you’d normally validate here -------------------------------
        final newEmail = await Navigator.push<String?>(
          context,
          MaterialPageRoute(
            builder: (_) => EnterNew(
              title : 'Enter new email',
              hint  : 'New email',
              onSave: (val) {
                Navigator.pop(context, val);   // pop EnterNew
              },
            ),
          ),
        );
        if (newEmail != null) {
          Navigator.pop(context, newEmail);    // pop whole flow
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email updated'),
              duration: Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }
}
