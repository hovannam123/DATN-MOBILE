// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:safe_food/src/resource/modules/login/login.dart';

// class PaymentPage extends StatefulWidget {
//   final String paypalUrl; // url thanh toán paypal

//   PaymentPage({required this.paypalUrl});

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   final flutterWebviewPlugin = FlutterWebviewPlugin();

//   @override
//   void initState() {
//     super.initState();
//     flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (url.isNotEmpty) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       }

//       // if (url == 'http://localhost:3000/api/v1/success') {
//       //   flutterWebviewPlugin.close();
//       //   print('aaaaaaaaa');

//       // }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       url: widget.paypalUrl,
//     );
//   }

//   @override
//   void dispose() {
//     flutterWebviewPlugin.dispose();
//     super.dispose();
//   }
// }
