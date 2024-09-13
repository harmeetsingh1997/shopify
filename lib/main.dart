import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/authentication/bloc/sign_up_bloc.dart';
import 'package:shopify/authentication/screens/splash_screen.dart';
import 'package:shopify/auth_data_source.dart';
import 'package:shopify/product/product_bloc/product_bloc.dart';
import 'package:shopify/product/product_data_source.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key, });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(UserRepository()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductDataSource()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
