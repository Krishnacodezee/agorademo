// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/apiProvider/country_api_provider.dart';
// import 'package:untitled/apiProvider/get_post_api_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:untitled/view/localization.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   // NativeNotify.initialize(
//   //     1262,
//   //     '6e5tI8TrK0j7r6NSoghG8o',
//   //     'AAAA0fhnyc4:APA91bGM3FF_1I0x0jFHDbqCzWIZBRHvQKB_WrBgeaBdcRXIbCcseGuBHEeRcWt2Ad7LyfnXJ7wWYtdyVmkJIJ3Bfuj_2e66c7z9NJcu6ZZEJsIHBoCp5yjnNbI-v8eDkGc2zqrSvLX1',
//   //     Icons.notifications);
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('ja', ''), Locale('en', '')],
//       path:
//           'assets/translations', // <-- change the path of the translations files
//       fallbackLocale: const Locale('ja', ''),
//       useFallbackTranslations: true,
//       child: MultiProvider(
//         providers: providers,
//         child: MyApp(),
//       ),
//     ),
//   );
// }
//
// var providers = [
//   ChangeNotifierProvider<countryDataProvider>(
//       create: (_) => countryDataProvider()),
//   ChangeNotifierProvider<GetPostApiDataProvider>(
//       create: (_) => GetPostApiDataProvider()),
// ];
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final _ezContext = EasyLocalization.of(context)!;
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: _ezContext.supportedLocales,
//       locale: _ezContext.fallbackLocale,
//       home: const Localization(),
//
//       //  routes: {
//       //    CountryScreen2.routeName: (context) =>
//       // const CountryScreen2(),
//       // },
//     );
//   }
// }
//
//todo:video call
// import 'package:flutter/material.dart';

// import './src/pages/index.dart';

// void main() => runApp(MyApp());

//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: IndexPage(),
//     );
//   }
// }
//
//
//todo:voice call

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';

import './src/pages/index.dart';

const APP_ID = 'ac8d1a0d46d74e1e8d70c5664a24e37e';
const Token =
    '006ac8d1a0d46d74e1e8d70c5664a24e37eIAAHuUI+Ii+s6rFdnf5muvFMaMUqKcRKe/GCWGVp3uUE6IAO3FUAAAAAEACWH508yc78YgEAAQDIzvxi';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Init the app
  Future<void> initPlatformState() async {
    // Get microphone permission
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone].request();
    }

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(APP_ID);
    var engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess ${channel} ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Join channel with channel name as 123
    await engine.joinChannel(Token, '123', null, 0);
  }

  // Build chat UI
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agora Audio quickstart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Agora Audio quickstart'),
        ),
        body: Center(
          child: Text('Please chat!'),
        ),
      ),
    );
  }
}
