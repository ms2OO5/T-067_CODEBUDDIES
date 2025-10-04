import 'package:flutter/material.dart';
import 'common_input_widget.dart';
import 'enter_new.dart';

class ChangePhoneFlow extends StatelessWidget {
  const ChangePhoneFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return EnterCurrent(
      title: 'Change Phone',
      hint : 'Current phone number',
      onNext: (currentPhone, pwd) async {
        final newPhone = await Navigator.push<String?>(
          context,
          MaterialPageRoute(
            builder: (_) => EnterNew(
              title : 'Enter new phone',
              hint  : 'New phone number',
              onSave: (val) => Navigator.pop(context, val),
            ),
          ),
        );
        if (newPhone != null) {
          Navigator.pop(context, newPhone);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Phone number updated'),
              duration: Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }
}
