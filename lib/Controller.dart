import 'dart:convert';
import 'dart:ui';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var imagePath = ''.obs;
  var imagePathList = <String>[].obs;

  var pathIndex = 0.obs;
  /*To update the index to show the path in draggable popup*/
  var isInfoPressed = false.obs;
  var windowcounter = 0.obs;
  var windowid1 = 0.obs;
  var windowid2 = 0.obs;
  var windowid3 = 0.obs;

  WindowController? window;
  List availableWindowList = ["hi"];

  /* List availableWindowList2 = [
    {"window": "a", "id": 0},
    {"window": "b", "id": 0},
    {"window": "c", "id": 0}
  ];*/

  @override
  void onInit() {
    super.onInit();
  }

  windowCounterIncrement() {
    windowcounter.value++;
    print("window counter: " + windowcounter.value.toString());
  }

  multiWindowCommon(String availableWindow, bool isNewWindow) async {
    // var a = availableWindowList2.first["id"].toString();
    // id.value = int.parse(availableWindowList2.first["id"]);
    if (availableWindowList.contains(availableWindow)) {
      print("already there");
      print(availableWindowList);

      try {
        if (availableWindow == "a") {
          await DesktopMultiWindow.invokeMethod(
              windowid1.value, "", "window 1st");
        }
        if (availableWindow == "b") {
          await DesktopMultiWindow.invokeMethod(
              windowid2.value, "", "window 2nd");
        }
        if (availableWindow == "c") {
          await DesktopMultiWindow.invokeMethod(
              windowid3.value, "", "window 3rd");
        }
        /* await DesktopMultiWindow.invokeMethod(
            windowcounter.value,
            "",
            availableWindow == "a"
                ? "window 1st $windowcounter"
                : availableWindow == "b"
                    ? "window 2nd $windowcounter"
                    : availableWindow == "c"
                        ? "window 3rd $windowcounter"
                        : '');*/
        // Log.i("already opened");
      } on Exception catch (_) {
        print('Exception catched');

        availableWindowList.remove(availableWindow);

        if (!availableWindowList.contains(availableWindow)) {
          creatingWindow(availableWindow);
        }
      }
    } else {
      creatingWindow(availableWindow);
    }
  }

  creatingWindow(String availableWindow) async {
    windowCounterIncrement();

    window =
        await DesktopMultiWindow.createWindow(jsonEncode({"args1": "Hello"}))
          ..setFrame(const Offset(0, 0) & const Size(500, 500))
          ..show();
    if (availableWindow == "a") {
      await DesktopMultiWindow.invokeMethod(
          windowcounter.value, "", "window 1st");
      windowid1.value = windowcounter.value;
    } else if (availableWindow == "b") {
      await DesktopMultiWindow.invokeMethod(
          windowcounter.value, "", "window 2nd");
      windowid2.value = windowcounter.value;
    } else if (availableWindow == "c") {
      await DesktopMultiWindow.invokeMethod(
          windowcounter.value, "", "window 3rd");
      windowid3.value = windowcounter.value;
    }

    print("opened new window");
    availableWindowList.add(availableWindow);
    // availableWindowList2.first["id"] = " $windowcounter";
//availableWindowList.add("$availableWindow -${windowcounter.value}");
    //print(availableWindowList2);
    print(availableWindowList);
    //isInfoPressed.value = false;
  }

  closeWindow() {
    if (window != null) {
      window!.close();
      window = null;
    }
  }
}
