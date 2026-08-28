import 'package:flutter/material.dart';
import '../../homePage.dart';
import '../../http/PostApiCalls.dart';
import './utils/DeviceInfo.dart';
import '../../widgets/InputFiled.dart';

class LoginPage extends StatefulWidget {
  final Function(Map<String, dynamic> payload)? onLogin;
  final String endpoint;

  const LoginPage({
    super.key,
    this.onLogin,
    this.endpoint = 'employee/auth/login',
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;
  bool loading = false;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Map<String, dynamic> get employeeLodinData => {
        "phoneNumber": phoneController.text.trim(),
        "password": passwordController.text,
        "device": DeviceInfo.deviceData,
      };

  void employeeLoginCall() {
    if (phoneController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showTopSnackBar('Please enter phone number and password', isSuccess: false);
      return;
    }

    final payload = employeeLodinData;
    widget.onLogin?.call(payload);

    PostApiCalls.post(
      endpoint: widget.endpoint,
      data: payload,
      onLoadingStart: () => setState(() => loading = true),
      onLoadingEnd: () => setState(() => loading = false),
      successCallback: (response) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      failedCallback: (response) {
        if (!mounted) return;
        final message = (response is Map && response['message'] != null)
            ? response['message'].toString()
            : 'Login failed';
        _showTopSnackBar(message, isSuccess: false);
      },
    );
  }

  void _showTopSnackBar(String message, {required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        backgroundColor: isSuccess ? Colors.green.shade600 : Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 130,
          left: 20,
          right: 20,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 6,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(Icons.person_pin, size: 44, color: Colors.blue.shade700),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Employee Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Sign in to access your workspace',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade500),
                      ),
                      const SizedBox(height: 28),

                      InputField(
                        label: 'Phone Number',
                        type: TextInputType.phone,
                        controller: phoneController,
                        placeholder: 'Enter phone number',
                        inputSelectedColor: Colors.blue.shade700,
                        textWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 16),

                      InputField(
                        label: 'Password',
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        placeholder: 'Enter password',
                        obscureText: !passwordVisible,
                        inputSelectedColor: Colors.blue.shade700,
                        textWeight: FontWeight.w500,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () => setState(() => passwordVisible = !passwordVisible),
                        ),
                      ),
                      const SizedBox(height: 28),

                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: loading ? null : employeeLoginCall,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: loading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                                )
                              : const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}