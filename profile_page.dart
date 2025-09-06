import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์ติวเตอร์'),
        automaticallyImplyLeading: false,
      ),
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
          ], // หน้าเปล่า
        ),
      ),
    );
  }
}
