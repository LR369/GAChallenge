import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:sustain_game/controllers/game_controller.dart';

class WalletController extends GetxController {
  var hasPass = false.obs;
  var addedPoints = false.obs;
  var showNextStep = false.obs;
  var showNextBtn = false.obs;
  var showAddToGoogleBtn = false.obs;
  var showViewGoogleBtn = false.obs;
  var receipient = "Enter an email address".obs;
  var username = "username".obs;
  var tokenLink = "".obs;
  var hasToken = false.obs;

  void reset() {
    hasPass.value = false;
    addedPoints.value = false;
    showNextStep.value = false;
    showNextBtn.value = false;
    showAddToGoogleBtn.value = false;
    showViewGoogleBtn.value = false;
    receipient.value = "Enter an email address";
    username.value = "username";
    tokenLink.value = "";
    hasToken.value = false;
  }

  changeHasPass() => hasPass;

  //https://vast-puce-blackbuck-tux.cyclic.app

  void addEmail(String text) {
    receipient.value = text;

    if (receipient.value.isEmpty) {
      receipient.value = "Enter an email address";
    } else {
      if (receipient.value.contains('@')) {
        showNextBtn.value = true;
      }
    }
    update();

    //update balance for this wallet
  }

  void addUsername(String text) {
    username.value = text;

    if (username.value.isEmpty) {
      username.value = "Enter a username";
    }

    //update balance for this wallet
  }

  createPass() async {
    // if (!username.value.contains(RegExp('r[a-z]')) ||
    //     !receipient.value.contains('@')) return;
    var url = Uri.parse("https://vast-puce-blackbuck-tux.cyclic.app/");
    var arr = {
      "email": receipient.value,
      "userName": username.value,
      "score": GameController.score,
    };

    final querParams = json.encode(arr);

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: querParams);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send.');
    }

    final responseJson = jsonDecode(response.body);
    print(responseJson);
    // if (responseJson["link"]) {
    //   print("haslink");
    // }

    if (responseJson["text"] == "True") {
      tokenLink.value = responseJson["link"];
      hasToken.value = true;
    } else if (responseJson["text"] == "False") {
      hasToken.value = false;
    }
    update();
  }

  // checkLink() {
  //   final linkb =
  //       "'https://pay.google.com/gp/v/save/eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnYWl'";

  //   print(linkb.replaceAllMapped(from, (match) => null));
  // }

  checkRequest() async {
    //  if (receipient.value.isEmpty) return;
    var url = Uri.parse("https://vast-puce-blackbuck-tux.cyclic.app/check");
    var arr = {"email": receipient.value};
    final querParams = json.encode(arr);
    print(querParams);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: querParams);

    if (response.statusCode == 200) {
      print(response.body);
      showNextStep.value = true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send.');
    }
    final responseJson = jsonDecode(response.body);
    print(responseJson);
    if (responseJson["text"] == "True") {
      hasPass.value = true;
    } else {
      hasPass.value = false;
    }
    showNextBtn.value = false;

    update();
  }

  // ckRequest() async {
  //   //  if (receipient.value.isEmpty) return;
  //   var url = Uri.parse("https://vast-puce-blackbuck-tux.cyclic.app/issue-2");
  //   var arr = {"email": receipient.value};
  //   final querParams = json.encode(arr);
  //   print(querParams);

  //   var response = await http.post(url,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: querParams);

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     showNextStep.value = true;

  //     // jsonDecode(response.body);
  //   } else {
  //     // If the server did not return a 201 CREATED response,
  //     // then throw an exception.
  //     throw Exception('Failed to send.');
  //   }

  //   final responseJson = jsonDecode(response.body);
  //   print(responseJson["text"]);
  //   if (responseJson["text"] == "True") {
  //     print("True");
  //     hasPass.value = true;
  //   }
  //   // updateBalance(responseJson);
  // }

  ///addPoints
  updateWalletPoints() async {
    if (receipient.value.isEmpty) return;
    var url = Uri.parse("https://vast-puce-blackbuck-tux.cyclic.app/addPoints");

    var arr = {"email": receipient.value, "score": GameController.score};

    final querParams = json.encode(arr);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: querParams);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send.');
    }

    final responseJson = jsonDecode(response.body);
    print(responseJson);
    // updateBalance(responseJson);
  }

  addPassToWalletPoints() {
    print(tokenLink.value);
    var link =
        tokenLink.value.replaceAll(RegExp(r"'"), " ").removeAllWhitespace;
    print(link);
    launchUrl(
      Uri.parse(link),
    );
    addedPoints.value = true;
  }
}
