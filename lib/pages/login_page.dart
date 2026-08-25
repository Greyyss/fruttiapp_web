import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _correoController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _recordarme = false;
  bool _ocultarPassword = true;

  @override
  void dispose() {
    _correoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _ingresar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6f4),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.shopping_basket,
                        size: 70,
                        color: Color.fromARGB(255, 132, 64, 204),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'FrutiApp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Ingresá a tu cuenta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 79, 76, 76),
                        ),
                      ),

                      const SizedBox(height: 30),

                      TextFormField(
                        controller: _correoController,
                        keyboardType:
                            TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Ingrese el correo';
                          }

                          if (!value.contains('@') ||
                              !value.contains('.')) {
                            return 'Correo no válido';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _ocultarPassword,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon:
                              const Icon(Icons.lock),
                          border:
                              const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _ocultarPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _ocultarPassword =
                                    !_ocultarPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Checkbox(
                            value: _recordarme,
                            onChanged: (value) {
                              setState(() {
                                _recordarme =
                                    value ?? false;
                              });
                            },
                          ),
                          const Text('Recordarme'),
                        ],
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _ingresar,
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
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