import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../l10n/app_localizations.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;

  Future<void> _submitFeedback() async {
    final feedbackText = controller.text.trim();
    if (feedbackText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.enterFeedback)),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection("feedbacks").add({
        "feedback": feedbackText,
        "uid": user?.uid ?? "guest",
        "email": user?.email ?? "guest",
        "timestamp": FieldValue.serverTimestamp(),
      });

      controller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.feedbackSuccess)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "${AppLocalizations.of(context)!.feedbackFail} $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.feedbackTitle),
        backgroundColor: Color(0xFFE4F8F0),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.feedbackHeading,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              loc.feedbackSubHeading,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: loc.feedbackHint,
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: isLoading
                      ? const CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white)
                      : const Icon(Icons.send),
                  label: Text(
                      isLoading ? loc.submitting : loc.submit),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE4F8F0),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isLoading ? null : _submitFeedback,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
