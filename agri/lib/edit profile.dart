import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String? currentEmail;
  final File? initialImageFile;
  final Function(String, String?, String, File?) onSave;

  const EditProfileScreen({
    Key? key,
    required this.currentName,
    required this.currentPhone,
    this.currentEmail,
    this.initialImageFile,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _birthdateController;
  String _selectedGender = 'Male';
  File? _imageFile;
  String _selectedRegion = 'Punjab/India';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _birthdateController = TextEditingController();
    _imageFile = widget.initialImageFile;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((doc) {
        if (doc.exists) {
          final data = doc.data()!;
          setState(() {
            _birthdateController.text = data['birthdate'] ?? '';
            _selectedGender = data['gender'] ?? 'Male';
            _selectedRegion = data['region'] ?? 'Punjab/India';
          });
        }
      });
    }
  }

  Future<bool> _request(Permission p) async => (await p.request()).isGranted;

  Future<void> _pick(ImageSource src) async {
    if (await _request(src == ImageSource.camera ? Permission.camera : Permission.photos)) {
      final pf = await ImagePicker().pickImage(source: src);
      if (pf != null) setState(() => _imageFile = File(pf.path));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.permissionDenied)),
      );
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: Text(AppLocalizations.of(context)!.takePhoto),
              onTap: () {
                Navigator.pop(context);
                _pick(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: Text(AppLocalizations.of(context)!.chooseFromGallery),
              onTap: () {
                Navigator.pop(context);
                _pick(ImageSource.gallery);
              },
            ),
            if (_imageFile != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(AppLocalizations.of(context)!.removePicture),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _imageFile = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _save() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': _nameController.text.trim(),
        'region': _selectedRegion,
        'birthdate': _birthdateController.text.trim(),
        'gender': _selectedGender,
        'phone': widget.currentPhone,
        'email': widget.currentEmail ?? '',
        'hasAvatar': _imageFile != null,
      }, SetOptions(merge: true));
    }

    widget.onSave(
      _nameController.text.trim(),
      widget.currentEmail,
      widget.currentPhone,
      _imageFile,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: Text(loc.editProfile, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: _showPicker,
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 16,
                      child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            if (widget.currentEmail != null)
              Text("${loc.email}: ${widget.currentEmail}", style: const TextStyle(fontSize: 14, color: Colors.black87)),
            const SizedBox(height: 4),
            Text("${loc.phone}: ${widget.currentPhone}", style: const TextStyle(fontSize: 14, color: Colors.black87)),
            const Divider(height: 40, thickness: 1),
            _textField(loc.name, _nameController),
            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: _textField(loc.birthdate, _birthdateController, hint: "DD-MM-YYYY"),
              ),
            ),
            _genderDropdown(),
            _regionDropdown(),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save, size: 20),
              label: Text(loc.saveChanges, style: const TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF46A24A),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController ctrl,
      {TextInputType keyboard = TextInputType.text, String? hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            keyboardType: keyboard,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _regionDropdown() {
    const items = ["Punjab/India", "Delhi/India", "Mumbai/India"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.stateRegion, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButton<String>(
            value: _selectedRegion,
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _selectedRegion = val!),
          ),
        ),
      ],
    );
  }

  Widget _genderDropdown() {
    const genders = ['Male', 'Female', 'Other'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.gender, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButton<String>(
            value: _selectedGender,
            isExpanded: true,
            underline: const SizedBox(),
            items: genders.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _selectedGender = val!),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
