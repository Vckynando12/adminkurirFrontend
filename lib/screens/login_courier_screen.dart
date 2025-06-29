import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginCourierScreen extends StatefulWidget {
  final VoidCallback onSwitchToSeller;
  const LoginCourierScreen({super.key, required this.onSwitchToSeller});

  @override
  State<LoginCourierScreen> createState() => _LoginCourierScreenState();
}

class _LoginCourierScreenState extends State<LoginCourierScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginTanpaKredensial() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loginTanpaKredensial('courier');
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo pojok kiri atas
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 0, bottom: 0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                  alignment: Alignment.topLeft,
                ),
              ),
              const SizedBox(height: 8),
              // Ilustrasi
              Center(
                child: Container(
                  height: 250,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Image.asset('assets/images/motor.jpg', fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 8),
              // Judul
              Text(
                'Masuk',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Email
              SizedBox(
                height: 44,
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    prefixIcon: Icon(Icons.email, color: Colors.blue[200], size: 22),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[200]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    contentPadding: const EdgeInsets.only(top: 2),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Password
              SizedBox(
                height: 44,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    prefixIcon: Icon(Icons.lock, color: Colors.blue[200], size: 22),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: Colors.blue[200], size: 22),
                      onPressed: () => setState(() => _obscure = !_obscure),
                      splashRadius: 18,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[200]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    contentPadding: const EdgeInsets.only(top: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Link bawah field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: widget.onSwitchToSeller,
                    child: const Text(
                      'Masuk sebagai Penjual',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Tombol masuk
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading ? null : _loginTanpaKredensial,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        elevation: 0,
                      ),
                      child: authProvider.isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              'Masuk',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 80),
              // Text bawah
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Tidak punya akun? ',
                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    children: [
                      TextSpan(
                        text: 'Hubungi Admin',
                        style: TextStyle(color: Colors.blue, fontSize: 13),
                      ),
                    ],
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