import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chansa_app/views/app.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Definición del estado de la aplicación
class MyAppState with ChangeNotifier {
  // Estado de autenticación
  User? _user;
  User? get user => _user;

  // Configuración de Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Iniciar sesión con Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        _user = user;
        notifyListeners();
      }
    } catch (error) {
      print('Error al iniciar sesión con Google: $error');
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}

// Pantalla a la que se redirige después del inicio de sesión
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Text('Bienvenido a la aplicación'),
      ),
    );
  }
}

// Pantalla de inicio de sesión
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Iniciar sesión con Google
            await myAppState.signInWithGoogle();
            // Redirigir a la pantalla principal si el inicio de sesión fue exitoso
            if (myAppState.user != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage()), // REEMPLAZAR POR LA APP DE CHANSA
              );
            }
          },
          child: Text('Iniciar sesión con Google'),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        home: MyApp(), // Establece MyApp como la pantalla inicial
      ),
    ),
  );
}
