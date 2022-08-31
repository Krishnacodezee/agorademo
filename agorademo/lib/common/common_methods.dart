import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

void openLink(String link) async {
  await UrlLauncher.launchUrl(Uri.parse(link));
}

GestureRecognizer? linkText1 = TapGestureRecognizer()
  ..onTap = () async {
    openLink(
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fstorage.googleapis.com%2Fcms-storage-bucket%2F70760bf1e88b184bb1bc.png&imgrefurl=https%3A%2F%2Fflutter.dev%2F&tbnid=TmThSb21aih5sM&vet=12ahUKEwjN4fWozcr5AhWPjNgFHUjtA_oQMygAegUIARDbAQ..i&docid=-AyL7-iBRb3f3M&w=937&h=461&q=flutter&ved=2ahUKEwjN4fWozcr5AhWPjNgFHUjtA_oQMygAegUIARDbAQ");
  };
GestureRecognizer? linkText2 = TapGestureRecognizer()
  ..onTap = () async {
    openLink(
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.zignuts.com%2Fwp-content%2Fuploads%2F2021%2F05%2FFlutter2.jpg&imgrefurl=https%3A%2F%2Fwww.zignuts.com%2Fblogs%2Fgoogle-released-flutter-2-to-support-web-based-applications%2F&tbnid=TifUePjZMypQrM&vet=12ahUKEwiIidCbz8r5AhWYk9gFHeB5CUIQMygDegUIARDFAQ..i&docid=kzFE3cNxOzIurM&w=811&h=392&q=flutter2&ved=2ahUKEwiIidCbz8r5AhWYk9gFHeB5CUIQMygDegUIARDFAQ");
  };
GestureRecognizer? linkText3 = TapGestureRecognizer()
  ..onTap = () async {
    openLink(
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fgamefromscratch.com%2Fwp-content%2Fuploads%2F2022%2F05%2FFlutter3.png&imgrefurl=https%3A%2F%2Fgamefromscratch.com%2Fflutter-3-and-casual-game-toolkit-released%2F&tbnid=N-oF6N57poZL_M&vet=12ahUKEwjtsemC2cr5AhVfjtgFHcfyDS8QMygDegUIARCzAQ..i&docid=psILPInlzgbrHM&w=1920&h=1080&q=flutter3&ved=2ahUKEwjtsemC2cr5AhVfjtgFHcfyDS8QMygDegUIARCzAQ");
  };
GestureRecognizer? linkText4 = TapGestureRecognizer()
  ..onTap = () async {
    openLink(
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fstorage.googleapis.com%2Fcms-storage-bucket%2F70760bf1e88b184bb1bc.png&imgrefurl=https%3A%2F%2Fflutter.dev%2F&tbnid=TmThSb21aih5sM&vet=12ahUKEwjN4fWozcr5AhWPjNgFHUjtA_oQMygAegUIARDbAQ..i&docid=-AyL7-iBRb3f3M&w=937&h=461&q=flutter&ved=2ahUKEwjN4fWozcr5AhWPjNgFHUjtA_oQMygAegUIARDbAQ");
  };
GestureRecognizer? linkText5 = TapGestureRecognizer()
  ..onTap = () async {
    ("https://www.google.com/imgres?imgurl=https%3A%2F%2Fplay-lh.googleusercontent.com%2FUuQ1NvkFc0oh4hlNWoIlAylkPbFtR2ObZCxZbcbJn7TXP9kfKD-KG6dRi4dDpeIMispi&imgrefurl=https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.infinium.pub_app%26hl%3Den_US%26gl%3DUS&tbnid=qa0k-TasZRff7M&vet=12ahUKEwjDsum8z8r5AhUiLrcAHdN-Ca4QMygDegUIARCPAQ..i&docid=4f1D3JtdnwqndM&w=512&h=250&q=pub.dev&ved=2ahUKEwjDsum8z8r5AhUiLrcAHdN-Ca4QMygDegUIARCPAQ");
  };
