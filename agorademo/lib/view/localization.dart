import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled/view/agora_calling.dart';
import 'package:untitled/view/country_screen2.dart';
import 'package:untitled/view/web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class Localization extends StatefulWidget {
  const Localization({Key? key}) : super(key: key);

  @override
  State<Localization> createState() => _LocalizationState();
}

class _LocalizationState extends State<Localization> {
  late final _ratingController;
  late double _rating;

  var androidSms = Uri.parse("sms:+39 348 060 888?body=hello%20there");
  var iosSms = Uri.parse("sms:0039-222-060-888?body=hello%20there");

  _textMe() async {
    if (Platform.isAndroid) {
      await UrlLauncher.launchUrl(androidSms);
    } else if (Platform.isIOS) {
      await UrlLauncher.launchUrl(iosSms);
    }
  }

  @override
  Widget build(BuildContext context) {
    final supportLocales = context.supportedLocales;
    final currentLocale = context.locale;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter demos'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: supportLocales
                  .map((locale) => _btn(context, locale, currentLocale))
                  .toList(),
            ),
            // App Maximize and minimize by on tap
            const SizedBox(height: 20),

            Center(
              //todo : Text localization

              child: Text(
                "title".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, color: Colors.teal),
              ),
            ),
            Center(
              child: Text(
                'translation'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CountryScreen2();
                }));
              },
              child: const Text(
                'Goto Next Screen2',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.cyan,
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 10),

            RatingBar.builder(
              //todo: ratingbar with url launch
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) async {
                print(rating);
                _textMe();
                await UrlLauncher.launchUrl(Uri.parse(
                    "https://play.google.com/store/games?utm_source=apac_med&utm_medium=hasem&utm_content=Oct0121&utm_campaign=Evergreen&pcampaignid=MKT-EDR-apac-in-1003227-med-hasem-py-Evergreen-Oct0121-Text_Search_BKWS-BKWS%7CONSEM_kwid_43700058906740291_creativeid_480977734925_device_c&gclid=CjwKCAjw6MKXBhA5EiwANWLODHx3tIEzRFK1FTOpnuxYA-5mrx6vpFxmfCxc_d-GILfp3oIqYOR4BhoCnNIQAvD_BwE&gclsrc=aw.ds"));
              },
            ),

            const SizedBox(height: 10),
            InkWell(
              child: Text(
                'WebView',
                style: new TextStyle(color: Colors.pinkAccent),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const WebViewScreen();
                }));
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              child: Text(
                'Agora Calling',
                style: new TextStyle(color: Colors.pinkAccent),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AgoraCalling();
                }));
              },
            ),

            const SizedBox(height: 80)
          ],
        ),
      ),
    );
  }

  Widget _btn(BuildContext context, Locale locale, Locale currentLocale) {
    final isActive = locale.languageCode == currentLocale.languageCode;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isActive ? Colors.blue : Colors.blue[100],
        ),
        onPressed: () => context.setLocale(locale),
        child: Text(locale.languageCode),
      ),
    );
  }
}
