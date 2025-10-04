import 'package:flutter/material.dart';


/// Main flow screen shown from ManageAccountsScreen
class ChangePasswordFlow extends StatefulWidget {
  const ChangePasswordFlow({Key? key}) : super(key: key);

  @override
  State<ChangePasswordFlow> createState() => _ChangePasswordFlowState();
}

class _ChangePasswordFlowState extends State<ChangePasswordFlow> {
  final _cur = TextEditingController();
  final _new1 = TextEditingController();
  final _new2 = TextEditingController();

  bool _obCur = true, _ob1 = true, _ob2 = true;

  @override
  void dispose() {
    _cur.dispose();
    _new1.dispose();
    _new2.dispose();
    super.dispose();
  }

  void _save() {
    if (_new1.text.trim().isEmpty ||
        _cur.text.trim().isEmpty ||
        _new1.text != _new2.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please check the inputs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: call backend API for password change

    Navigator.pop(context, true); // success to ManageAccountsScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _pwField(_cur, 'Current password', _obCur, () => setState(() => _obCur = !_obCur)),
            const SizedBox(height: 16),
            _pwField(_new1, 'New password', _ob1, () => setState(() => _ob1 = !_ob1)),
            const SizedBox(height: 16),
            _pwField(_new2, 'Confirm new password', _ob2, () => setState(() => _ob2 = !_ob2)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black,
              ),
              child: const Text('Save changes', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const _TryAnotherWayFlow()),
                ).then((success) {
                  if (success == true) Navigator.pop(context, true);
                }),
                child: const Text('Try another way'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pwField(TextEditingController c, String h, bool ob, VoidCallback t) {
    return TextField(
      controller: c,
      obscureText: ob,
      decoration: InputDecoration(
        hintText: h,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(ob ? Icons.visibility : Icons.visibility_off),
          onPressed: t,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _TryAnotherWayFlow extends StatelessWidget {
  const _TryAnotherWayFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _EnterContact(
      onNext: (contact) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _EnterOTP(contact: contact)),
      ),
    );
  }
}

class _EnterContact extends StatelessWidget {
  final void Function(String) onNext;
  const _EnterContact({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify identity'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _singleFieldLayout(
        hint: 'Email or phone',
        controller: ctl,
        btnLabel: 'Send OTP',
        onPressed: () {
          if (ctl.text.trim().isNotEmpty) onNext(ctl.text.trim());
        },
      ),
    );
  }
}

class _EnterOTP extends StatelessWidget {
  final String contact;
  const _EnterOTP({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _singleFieldLayout(
        hint: 'OTP sent to $contact',
        controller: ctl,
        btnLabel: 'Verify',
        keyboardType: TextInputType.number,
        onPressed: () {
          if (ctl.text.length == 6) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const _EnterNewAfterOTP()),
            );
          }
        },
      ),
    );
  }
}

class _EnterNewAfterOTP extends StatefulWidget {
  const _EnterNewAfterOTP({Key? key}) : super(key: key);

  @override
  State<_EnterNewAfterOTP> createState() => _EnterNewAfterOTPState();
}

class _EnterNewAfterOTPState extends State<_EnterNewAfterOTP> {
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();
  bool _ob1 = true, _ob2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set new password'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _pw(_p1, 'New password', _ob1, () => setState(() => _ob1 = !_ob1)),
            const SizedBox(height: 16),
            _pw(_p2, 'Confirm password', _ob2, () => setState(() => _ob2 = !_ob2)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_p1.text.trim().isEmpty || _p1.text != _p2.text) return;

                // TODO: send to backend here

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password updated'),
                    duration: Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                // Pop back to ManageAccountsScreen
                Navigator.pop(context); // _EnterNewAfterOTP
                Navigator.pop(context); // _EnterOTP
                Navigator.pop(context); // _EnterContact
                Navigator.pop(context, true); // ChangePasswordFlow -> return success
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black,
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pw(TextEditingController c, String h, bool ob, VoidCallback t) =>
      TextField(
        controller: c,
        obscureText: ob,
        decoration: InputDecoration(
          hintText: h,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(ob ? Icons.visibility : Icons.visibility_off),
            onPressed: t,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
}

/// One-field reusable layout
Widget _singleFieldLayout({
  required String hint,
  required TextEditingController controller,
  required String btnLabel,
  required VoidCallback onPressed,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.black,
          ),
          child: Text(btnLabel, style: const TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
