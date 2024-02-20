import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String currentUrl = 'https://appv2.starkregen.de';
  bool showNavBar = false;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(currentUrl))
    ..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (NavigationRequest request) {
        if (request.url == currentUrl) {
          setState(() {
            showNavBar = false;
          });
        } else {
          setState(() {
            showNavBar = true;
          });
        }
        ;
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
        setState(() {
          currentUrl = url;
        });
      },
    ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebViewWidget(controller: controller),
        bottomNavigationBar: showNavBar
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Business',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'School',
                  ),
                ],
                selectedItemColor: Colors.amber[800],
                onTap: (int index) {
                  print('Tapped index: $index');
                },
              )
            : null);
  }
}
