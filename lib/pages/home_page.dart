import 'package:flutter/material.dart';
import '../services/productos_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _productos;

  @override
  void initState() {
    super.initState();

    _productos =
        ProductosService.cargarProductos();
  }

  void _recargar() {
    setState(() {
      _productos =
          ProductosService.cargarProductos();
    });
  }

  void _cerrarSesion() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xfff3f6f4),

      appBar: AppBar(
        title: const Text('FrutiApp Web'),
        backgroundColor:
            const Color.fromARGB(255, 74, 15, 102),
        foregroundColor:
            Colors.white,
        actions: [
          IconButton(
            tooltip: 'Recargar',
            onPressed: _recargar,
            icon:
                const Icon(Icons.refresh),
          ),

          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed:
                _cerrarSesion,
            icon:
                const Icon(Icons.logout),
          ),
        ],
      ),

      body:
          FutureBuilder<List<dynamic>>(
        future: _productos,
        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 70,
                    color: Colors.red,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  const Text(
                    'No se pudo cargar la información.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  ElevatedButton(
                    onPressed:
                        _recargar,
                    child:
                        const Text(
                      'Reintentar',
                    ),
                  ),
                ],
              ),
            );
          }

          final productos =
              snapshot.data ?? [];

          return LayoutBuilder(
            builder: (
              context,
              constraints,
            ) {
              return Column(
                children: [
                  Container(
                    width:
                        double.infinity,
                    padding:
                        const EdgeInsets.all(
                            24),
                    color:
                        const Color.fromARGB(255, 218, 173, 232),
                    child:
                        const Column(
                      children: [
                        Text(
                          'Catálogo de productos',
                          style:
                              TextStyle(
                            fontSize: 26,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Productos obtenidos mediante una API REST',
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child:
                        ListView.builder(
                      padding:
                          const EdgeInsets.all(
                              20),
                      itemCount:
                          productos.length,
                      itemBuilder:
                          (
                        context,
                        index,
                      ) {
                        final producto =
                            productos[
                                index];

                        final int id =
                            producto[
                                'id'];

                        final String
                            nombre =
                            producto[
                                'title'];

                        final int precio =
                            id *
                                100;

                        return Card(
                          margin:
                              const EdgeInsets.only(
                            bottom:
                                12,
                          ),
                          child:
                              ListTile(
                            leading:
                                CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 124, 232, 231),
                              foregroundColor:
                                  Colors
                                      .white,
                              child: Text(
                                id.toString(),
                              ),
                            ),
                            title:
                                Text(
                              nombre,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                Text(
                              'Precio: ₡$precio',
                            ),
                            trailing:
                                const Icon(
                              Icons
                                  .shopping_cart_outlined,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}