import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/src/resource/modules/user/introduce/introduce.dart';
import 'package:safe_food/src/resource/provider/bill_item_provider.dart';
import 'package:safe_food/src/resource/provider/cart_item_provider.dart';
import 'package:safe_food/src/resource/provider/facebook_provider.dart';
import 'package:safe_food/src/resource/provider/google_provider.dart';
import 'package:safe_food/src/resource/provider/login_provider.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleProvider()),
        ChangeNotifierProvider(create: (context) => FacebookProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (context) => CartItemProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => BillProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'NanumBarunGothic',
              scaffoldBackgroundColor: Colors.transparent,
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(bodyColor: Colors.black, displayColor: Colors.black)),
          home: IntroScreen()
          // home: Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: [
          //         Colors.pink,
          //         Colors.yellow.shade100,
          //       ],
          //     ),
          //   ),
          //   child: HomePage(),
          // ),
          ),
      // home: Scaffold(body: SingleChildScrollView(
      //     child: Consumer<FacebookProvider>(builder: (context, value, child) {
      //   if (value.account != null) {
      //     return gotofb(value);
      //   } else {
      //     return HomePage();
      //   }
      // })
      // )
      // ),
    );
  }

  loginUI() {
    return Consumer<GoogleProvider>(builder: (context, model, child) {
      if (model.account != null) {
        return gotodetails(model);
      } else {
        return IntroScreen();
      }
    });
  }

  gotodetails(GoogleProvider model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(model.account!.displayName ?? ''),
          Text(model.account!.email),
          Text(model.token),
          Text('login success'),
          ElevatedButton.icon(
            icon: Icon(Icons.logout),
            onPressed: () {
              model.logOut();
            },
            label: Text('Logout'),
          )
        ],
      ),
    );
  }

  gotofb(FacebookProvider value) {
    return Column(
      children: [
        Text('login success'),
        Text(value.account!.accessToken!.token),
        TextButton(
            onPressed: () {
              value.logOut();
            },
            child: Text('logout'))
      ],
    );
  }
}