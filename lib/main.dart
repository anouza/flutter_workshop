import 'package:flutter/material.dart';
import 'package:flutter_workshop/pages/login/login.dart';
import 'package:flutter_workshop/providers/appdata_provider.dart';
import 'package:flutter_workshop/providers/loandetails_provider.dart';
import 'package:flutter_workshop/providers/tabindex_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
        ChangeNotifierProvider(create: (_) => TabIndexProvider()),
        ChangeNotifierProvider(create: (_) => LoanDetailsProvider()),
      ],
      child: MaterialApp(
          title: 'ForexLoan',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
            fontFamily: 'NotoSansLao'
          ),
          // home: const TabsPage() //const MyHomePage(title: 'Forex & Loan'),
          home: const LoginPage(),
          ),
    );
  }
}
