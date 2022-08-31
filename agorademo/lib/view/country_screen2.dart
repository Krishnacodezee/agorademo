import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/apiProvider/country_api_provider.dart';
import 'package:untitled/common/common_methods.dart';
import 'package:untitled/view/get_post_api_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher_string.dart';

class CountryScreen2 extends StatefulWidget {
  const CountryScreen2({Key? key}) : super(key: key);

  @override
  State<CountryScreen2> createState() => _CountryScreen2State();
}

var result;

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}

class _CountryScreen2State extends State<CountryScreen2> {
  TextEditingController textController = TextEditingController();
  late int _totalNotifications;
  // late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;
  @override
  void initState() {
    _totalNotifications = 0;
    getData();
    super.initState();
  }

  // void registerNotification() async {
  //   // 1. Initialize the Firebase app
  //   await Firebase.initializeApp();
  //
  //   // 2. Instantiate Firebase Messaging
  //   _messaging = FirebaseMessaging.instance;
  //
  //   // 3. On iOS, this helps to take the user permissions
  //   NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       // ...
  //       if (_notificationInfo != null) {
  //         // For displaying the notification as an overlay
  //         showSimpleNotification(
  //           Text(_notificationInfo!.title!),
  //           leading: NotificationBadge(totalNotifications: _totalNotifications),
  //           subtitle: Text(_notificationInfo!.body!),
  //           background: Colors.cyan.shade700,
  //           duration: Duration(seconds: 2),
  //         );
  //       }
  //     });
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  getData() async {
    final countryModal =
        Provider.of<countryDataProvider>(context, listen: false);
    countryModal.getCountryData(context);
    print(countryModal);
    setState(() {});
  }

  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native \n--------- interfaces on iOS and Android in record time. // Flutter is Google’s mobile UI framework for crafting high-quality native \n-------------- interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";

  bool flag = true;
  var newUrl = Uri.parse(
      "https://shukream.atlassian.net/jira/software/projects/CC/boards/4");
  var url = Uri.parse("tel://21213123123");
  var androidSms = Uri.parse("sms:+39 348 060 888?body=hello%20there");
  var iosSms = Uri.parse("sms:0039-222-060-888?body=hello%20there");

  // makingPhoneCall() async {
  //   if (await UrlLauncher.canLaunchUrl(url)) {
  //     await UrlLauncher.launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  //
  // InkWell(
  // onTap: () {
  // String url = 'tel:' + directory.phone.replaceAll(' ','');
  // launch(url);
  // print(url);
  // },
  //

  _textMe() async {
    if (Platform.isAndroid) {
      await UrlLauncher.launchUrl(androidSms);
    } else if (Platform.isIOS) {
      await UrlLauncher.launchUrl(iosSms);
    }
  }

  @override
  Widget build(BuildContext context) {
    // todo: api data calling using provider
    final countryModal = Provider.of<countryDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Country Screen',
          textAlign: TextAlign.center,
        ),
        leading: const BackButton(),
      ),
      body: countryModal.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  countryModal.CountryData.country![0].probability.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, color: Colors.teal),
                ),
                Text(
                  countryModal.CountryData.name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, color: Colors.teal),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    result ?? "",
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final newResult = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const GetPostApiDataScreen();
                    }));
                    setState(() {
                      result = newResult;
                    });
                  },
                  child: const Text(
                    'Goto Next screen3',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.cyan,
                        decoration: TextDecoration.underline),
                  ),
                ),
                TextField(
                  //todo: textfield with entered character count
                  controller: textController,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  maxLength: 10,
                  maxLines: 1,
                  onChanged: (text) {
                    textController.text = text;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter texxt',
                  ),
                ),
                const SizedBox(height: 16.0),
                _notificationInfo != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TITLE: ${_notificationInfo!.title}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'BODY: ${_notificationInfo!.body}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 16.0),
                Wrap(
                  children: <Widget>[
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          children: <Widget>[
                            // todo : app collapse and trim
                            Text(
                              description,
                              overflow: flag ? TextOverflow.ellipsis : null,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    flag ? "show more" : "show less",
                                    style: new TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  //todo: alert dialouge
                  child: Text(
                    'dialouge',
                    style: new TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          const AlertDialog(title: Text('Material Alert!')),
                    );
                  },
                ),
                InkWell(
                  //todo : launch web url
                  child: Text(
                    'url launch',
                    style: new TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    UrlLauncher.launchUrl(
                      newUrl,
                      mode: LaunchMode.inAppWebView,
                    );
                  },
                ),
                InkWell(
                  //todo : launch mobile url

                  child: Text(
                    'call',
                    style: new TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    UrlLauncher.launchUrl(url);
                    // UrlLauncher.launch("tel://21213123123");
                    // makingPhoneCall();
                  },
                ),
                InkWell(
                  //todo : launch sms url

                  child: Text(
                    'sms',
                    style: new TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    _textMe();
                  },
                ),
                const SizedBox(height: 16.0),
                RichText(
                  text: TextSpan(
                    // style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: 'text1',
                        style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 35,
                            decoration: TextDecoration.underline),
                        recognizer: linkText1,
                      ),
                      TextSpan(
                          text: '\ntext2',
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 35,
                              decoration: TextDecoration.underline),
                          recognizer: linkText2),
                      TextSpan(
                          text: '\ntext3',
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 35,
                              decoration: TextDecoration.underline),
                          recognizer: linkText3),
                      TextSpan(
                          text: '\ntext4',
                          style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 35,
                              decoration: TextDecoration.underline),
                          recognizer: linkText4),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
    );
    // return OverlaySupport(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(
    //         'Country Screen',
    //         textAlign: TextAlign.center,
    //       ),
    //       leading: const BackButton(),
    //     ),
    //     body: countryModal.loading
    //         ? const Center(child: CircularProgressIndicator())
    //         : Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               const SizedBox(height: 20),
    //               Text(
    //                 countryModal.CountryData.country![0].probability.toString(),
    //                 textAlign: TextAlign.center,
    //                 style: const TextStyle(fontSize: 24, color: Colors.teal),
    //               ),
    //               Text(
    //                 countryModal.CountryData.name ?? '',
    //                 textAlign: TextAlign.center,
    //                 style: const TextStyle(fontSize: 24, color: Colors.teal),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(32.0),
    //                 child: Text(
    //                   result ?? "",
    //                   style: const TextStyle(fontSize: 24),
    //                 ),
    //               ),
    //               TextButton(
    //                 onPressed: () async {
    //                   final newResult = await Navigator.push(context,
    //                       MaterialPageRoute(builder: (context) {
    //                     return const GetPostApiDataScreen();
    //                   }));
    //                   setState(() {
    //                     result = newResult;
    //                   });
    //                 },
    //                 child: const Text(
    //                   'Goto Next screen3',
    //                   style: TextStyle(
    //                       fontSize: 24,
    //                       color: Colors.cyan,
    //                       decoration: TextDecoration.underline),
    //                 ),
    //               ),
    //               TextField(
    //                 controller: textController,
    //                 maxLengthEnforcement:
    //                     MaxLengthEnforcement.truncateAfterCompositionEnds,
    //                 maxLength: 10,
    //                 maxLines: 1,
    //                 onChanged: (text) {
    //                   textController.text = text;
    //                 },
    //                 decoration: const InputDecoration(
    //                   hintText: 'Enter texxt',
    //                 ),
    //               ),
    //               SizedBox(height: 16.0),
    //               _notificationInfo != null
    //                   ? Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'TITLE: ${_notificationInfo!.title}',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 16.0,
    //                           ),
    //                         ),
    //                         SizedBox(height: 8.0),
    //                         Text(
    //                           'BODY: ${_notificationInfo!.body}',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 16.0,
    //                           ),
    //                         ),
    //                       ],
    //                     )
    //                   : Container(),
    //               SizedBox(height: 16.0),
    //             ],
    //           ),
    //   ),
    // );
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
