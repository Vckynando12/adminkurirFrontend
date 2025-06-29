import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_seller_screen.dart';
import 'login_courier_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isCourier = false;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginTanpaKredensial() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loginTanpaKredensial(_isCourier ? 'courier' : 'seller');
    if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCourier) {
      return LoginCourierScreen(
        onSwitchToSeller: () => setState(() => _isCourier = false),
      );
    } else {
      return LoginSellerScreen(
        onSwitchToCourier: () => setState(() => _isCourier = true),
      );
    }
  }
} 