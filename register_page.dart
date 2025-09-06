import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nicknameCtl = TextEditingController();
  final _phoneCtl = TextEditingController();
  final _lineCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  final _confirmCtl = TextEditingController();

  @override
  void dispose() {
    _nicknameCtl.dispose();
    _phoneCtl.dispose();
    _lineCtl.dispose();
    _passwordCtl.dispose();
    _confirmCtl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nickname", _nicknameCtl.text.trim());
    await prefs.setString("phone", _phoneCtl.text.trim());
    await prefs.setString("lineId", _lineCtl.text.trim());
    await prefs.setString("password", _passwordCtl.text);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("ลงทะเบียนเรียบร้อยแล้ว")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ลงทะเบียนติวเตอร์")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ชื่อเล่น
              TextFormField(
                controller: _nicknameCtl,
                decoration: const InputDecoration(
                  labelText: "ชื่อเล่น",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return 'กรุณากรอกชื่อเล่น';
                  if (t.length < 2) return 'อย่างน้อย 2 ตัวอักษร';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // เบอร์โทร
              TextFormField(
                controller: _phoneCtl,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  labelText: "เบอร์โทร",
                  helperText: "ใส่ตัวเลข 10 หลัก",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final t = (v ?? '').trim();
                  if (t.isEmpty) return 'กรุณากรอกเบอร์โทร';
                  if (t.length != 10) return 'ต้องเป็น 10 หลัก';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // ไอดีไลน์
              TextFormField(
                controller: _lineCtl,
                decoration: const InputDecoration(
                  labelText: "ไอดีไลน์",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return 'กรุณากรอกไอดีไลน์';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // รหัสผ่าน
              TextFormField(
                controller: _passwordCtl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "รหัสผ่าน",
                  helperText: "อย่างน้อย 6 ตัวอักษร",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final t = v ?? '';
                  if (t.isEmpty) return 'กรุณากรอกรหัสผ่าน';
                  if (t.length < 6) return 'อย่างน้อย 6 ตัวอักษร';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // ยืนยันรหัสผ่าน
              TextFormField(
                controller: _confirmCtl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "ยืนยันรหัสผ่าน",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                validator: (v) {
                  final t = v ?? '';
                  if (t.isEmpty) return 'กรุณายืนยันรหัสผ่าน';
                  if (t != _passwordCtl.text) return 'รหัสผ่านไม่ตรงกัน';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text("บันทึก"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
