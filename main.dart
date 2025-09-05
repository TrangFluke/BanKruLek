import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_page.dart';
import 'profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFE4E1), // สีไข่ชมพู
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 100,
              ),
            ),
            const SizedBox(height: 60),
            // ปุ่ม Admin
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.lock),
                label: const Text('Admin Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // ปุ่มลงทะเบียนติวเตอร์
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text('ลงทะเบียนติวเตอร์'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // ปุ่มเข้าสู่ระบบติวเตอร์
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showTutorLoginDialog(context);
                },
                icon: const Icon(Icons.login),
                label: const Text('เข้าสู่ระบบติวเตอร์'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTutorLoginDialog(BuildContext context) {
    final nickCtl = TextEditingController();
    final passCtl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('เข้าสู่ระบบติวเตอร์'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nickCtl,
                decoration: const InputDecoration(
                  labelText: 'ชื่อเล่นติวเตอร์',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passCtl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่าน',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () async {
                final inputNick = nickCtl.text.trim();
                final inputPass = passCtl.text;
                final messenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);

                final prefs = await SharedPreferences.getInstance();

                final savedNick = prefs.getString('nickname') ?? '';
                final savedPass = prefs.getString('password') ?? '';

                if (inputNick.isEmpty || inputPass.isEmpty) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('กรอกให้ครบ')),
                  );
                  return;
                }

                if (inputNick == savedNick && inputPass == savedPass) {
                  navigator.pop(); // ปิด dialog
                  navigator.push(
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                  );
                } else {
                  messenger.showSnackBar(
                    const SnackBar(
                        content: Text('ชื่อเล่นหรือรหัสผ่านไม่ถูกต้อง')),
                  );
                }
              },
              child: const Text('เข้าสู่ระบบ'),
            ),
          ],
        );
      },
    );
  }
}
