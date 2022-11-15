import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myshop/ui/NhatKy/GhiChuAddScreen.dart';
import 'package:myshop/ui/NhatKy/GhiChuControler.dart';
import 'ui/Mission/NhiemVuController.dart';
import 'package:provider/provider.dart';

import 'models/GhiChu.dart';
import 'ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NhiemVuControler(),
        ),
        ChangeNotifierProxyProvider<AuthManager, GhiChuControler>(
          create: (context) => GhiChuControler(),
          update: (context, authManager, ghiChuControler) {
            ghiChuControler!.authToken2 = authManager.authToken;
            return ghiChuControler;
          },
        ),
      ],
      child: Consumer<AuthManager>(builder: (context, authManager, child) {
        return MaterialApp(
          title: 'Nhật ký sinh viên',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.lightBlue,
            ).copyWith(
              secondary: Colors.deepOrange,
            ),
          ),
          home: authManager.isAuth
              ? const GhiChuScreen()
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: ((context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  }),
                ),
          routes: {
            GhiChuAddScreen.routeName: (ctx) => const GhiChuAddScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == GhiChuDetailsScreen.routeName) {
              final nhatKy = settings.arguments as GhiChu;
              return MaterialPageRoute(
                builder: (ctx) {
                  return GhiChuDetailsScreen(nhatKy);
                },
              );
            }
            return null;
          },
        );
      }),
    );
  }
}
