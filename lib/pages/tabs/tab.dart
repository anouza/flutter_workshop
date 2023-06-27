import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_workshop/pages/fx/fx_calculator.dart';
import 'package:flutter_workshop/pages/fx/fx_dashboard.dart';
import 'package:flutter_workshop/pages/home/home.dart';
import 'package:flutter_workshop/pages/loan/loan_calculator.dart';
import 'package:flutter_workshop/pages/login/login.dart';
import 'package:flutter_workshop/providers/tabindex_provider.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  // constructor
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  // find way to make dynamic later
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const ExchangeRateDashboardPage(),
    const LoanCalculatorPage(),
    const ExchangeCalculatorPage()
  ];

  int _selectedIndex = 0;
  String titleText = 'Forex & Loan';
  var storage = const FlutterSecureStorage();
  String _user = "";

  logout() {
    // storage.deleteAll();
    if (context.mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }
  }

  @override
  void initState() {
    super.initState();

    readUser();
  }

  readUser() async {
    await storage.read(key: "user").then((value) => setState(() {
          if(value != null) _user = value.toString();
        }));
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color(0xFF1e8bfa);
    final tabIndexProvider =
        Provider.of<TabIndexProvider>(context, listen: false);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Consumer<TabIndexProvider>(
            builder: (context, value, child) => Text(
                  value.pageTitle,
                  style: const TextStyle(color: Colors.white),
                )),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text("Forex & Loan"),
                  accountEmail: Text("User: $_user"),
                  currentAccountPicture: const CircleAvatar(
                    // ignore: prefer_interpolation_to_compose_strings
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                  ),
                  decoration: BoxDecoration(color: primaryColor),
                ),
                ListTile(
                  title: const ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                  ),
                  onTap: () {
                    tabIndexProvider.updateIndex(0);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const ListTile(
                    leading: Icon(Icons.attach_money_sharp),
                    title: Text("Exchange Rates"),
                  ),
                  onTap: () {
                    tabIndexProvider.updateIndex(1);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const ListTile(
                    leading: Icon(Icons.percent),
                    title: Text("Loan Calculator"),
                  ),
                  onTap: () {
                    tabIndexProvider.updateIndex(2);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const ListTile(
                    leading: Icon(Icons.currency_exchange),
                    title: Text("Rate Conversion"),
                  ),
                  onTap: () {
                    tabIndexProvider.updateIndex(3);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      visualDensity: const VisualDensity(horizontal: -4),
                      title: const Text("Logout"),
                      onTap: logout,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: //After
          Consumer<TabIndexProvider>(builder: (context, value, child) {
        _selectedIndex = value.selectedIndex;

        return IndexedStack(
          index: _selectedIndex,
          children: _pages,
        );
      }),
      bottomNavigationBar:
          Consumer<TabIndexProvider>(builder: (context, value, child) {
        _selectedIndex = value.selectedIndex;

        return BottomNavigationBar(
          backgroundColor: primaryColor,
          iconSize: 30,
          unselectedItemColor: const Color.fromARGB(125, 255, 255, 255),
          selectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_sharp),
              label: 'Rates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.percent),
              label: 'Loan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: 'Convert',
            )
          ],
          currentIndex: _selectedIndex, //New
          onTap: (int index) {
            _selectedIndex = index;
            value.updateIndex(index);
          },
          type: BottomNavigationBarType.fixed,
        );
      }),
    );
  }

  _onItemTapped(int index) {
    _selectedIndex = index;

    setState(() {
      switch (index) {
        case 0:
          titleText = "Forex & Loan";
          break;
        case 1:
          titleText = "Exchange Rates";
          break;
        case 2:
          titleText = "Loan Calculator";
          break;
        case 3:
          titleText = "Rate Conversion";
          break;
        default:
      }
    });
  }
}
