import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:air_hub_social/screens/home_page/home_page.dart';
import 'package:air_hub_social/screens/forgot_pass/Forgot_pass.dart'; // ajuste o caminho se necessário


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fundo branco como FB
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.flight_takeoff,
                    size: 60, color: Colors.blue), // ícone simples
                const SizedBox(height: 16),
                const Text(
                  'Bem-vindo!',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),

                // Email
                SizedBox(
                  width: 350, // largura da caixa
                  child: _buildInputField(
                    controller: emailController,
                    label: "E-mail",
                    icon: Icons.email,
                    validator: (value) =>
                    value == null || value.isEmpty ? "Digite seu e-mail" : null,
                  ),
                ),

                const SizedBox(height: 10),

                // Senha
                SizedBox(
                  width: 350, // largura da caixa
                  child: _buildInputField(
                    controller: senhaController,
                    label: "Senha",
                    icon: Icons.lock_open_rounded,
                    validator: (value) =>
                    value == null || value.isEmpty ? "Digite seu e-mail" : null,
                  ),
                ),
                const SizedBox(height: 10),

                // Botão Login
              SizedBox(
                width: 150, // largura total
                height: 30,
                // altura do botão
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // botão azul FB
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0, // remove sombra
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: senhaController.text.trim(),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Erro ao logar: $e")),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18, color: Colors.white), // aumenta fonte tbm
                  ),
                ),
              ),

              const SizedBox(height: 12),

                // Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordResetPage(),
                          ),
                        );
                      },

                      child: const Text(
                        "Esqueci minha senha",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Criar conta
                      },
                      child: const Text(
                        "Criar nova conta",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.black87, fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey, size: 18),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Colors.grey.shade200,
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 11,
        ),
      ),
    );
  }
}
